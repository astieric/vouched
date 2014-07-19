require 'rubygems'
require 'yajl'
require 'active_record'
require 'redis'
require 'bunny'
require 'neography'

require_relative 'models/user.rb'
require_relative 'models/ranking_job.rb'

env = ENV["SINATRA_ENV"] || "development"
databases = YAML.load_file("config/database.yml")
ActiveRecord::Base.establish_connection(databases[env])

client = Bunny.new(:host => "localhost", :logging => false)

# start a communication session with the amqp server
client.start

# create/get queue
ranking_work_queue = client.queue('ranking_work_queue')

# create/get exchange
ranking_exchange = client.exchange("ranking", :type => :fanout, :durable => true)

# bind queue to exchange
ranking_work_queue.bind(ranking_exchange)

# Setup Neo4j and Redis servers
Neography::Config.server = 'localhost'
redis = Redis.new

# subscribe to queue
ranking_work_queue.subscribe(:ack => true) do |msg|

begin
  params = Yajl::Parser.new.parse(msg[:payload])["ranking_job"]

  puts "Starting user #{params["user_id"]} for #{params["level"]} at #{Time.now}"

  job = RankingJob.where(:user_id => params["user_id"], :level => params["level"], :started => false, :finished => false).first
  job.started = true
  job.requests = 0
  job.save

  # Get user node 
  user_node = Neography::Node.load(User.find_by_id(params["user_id"]).user_node)

  # Get vouched users graph at the level specified and store in redis
  user_node.outgoing(:vouched).order("breadth first").uniqueness("node global").filter("position.length() == #{ params["level"] -1 } ;").depth(params["level"] - 1).map { |n| redis.sadd("users:#{params["user_id"]}:vouched#{params["level"]}", n.user_) }

  # Mark job finished.
  job = RankingJob.where(:user_id => params["user_id"], :level => params["level"], :started => true, :finished => false).first
  job.finished = true
  job.save

  # if more job requests came in while still processing, do them.
  if job.requests > 0
    job = RankingJob.create_or_update(:user_id => params["user_id"], :level => params["level"])
    ranking_exchange.publish(job.to_json)
  end

rescue Exception => e
  puts "crapped out #{e.inspect}"
  if job.valid?
    job.started = false
    job.finished = false
    job.save
    ranking_exchange.publish(job.to_json)
  end
end

ActiveRecord::Base.connection_pool.release_connection

end

# Close client
client.stop