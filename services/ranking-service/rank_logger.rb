require 'rubygems'
require 'bunny'
require 'active_record'

client = Bunny.new(:host => "localhost", :logging => false)

env = ENV["SINATRA_ENV"] || "development"
databases = YAML.load_file("config/database.yml")
ActiveRecord::Base.establish_connection(databases[env])

require 'models/term.rb'

# start a communication session with the amqp server
client.start

# create/get queue
rank_log_queue = client.queue('rank_log_queue')

# create/get exchange
rank_exchange = client.exchange("rank", :type => :fanout, :durable => true)

# bind queue to exchange
rank_log_queue.bind(rank_exchange)

# subscribe to queue
rank_log_queue.subscribe(:ack => true) do |msg|
  term = Term.where(:id => msg[:payload]).first

  puts "Received request to rank #{term.name}"
  ActiveRecord::Base.connection_pool.release_connection
end

# Close client
client.stop