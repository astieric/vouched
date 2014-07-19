require 'rubygems'
require 'yajl'
require 'bunny'

client = Bunny.new(:host => "localhost", :logging => false)

# start a communication session with the amqp server
client.start

# create/get queue
ranking_log_queue = client.queue('ranking_log_queue')

# create/get exchange
ranking_exchange = client.exchange("ranking", :type => :fanout, :durable => true)

# bind queue to exchange
ranking_log_queue.bind(ranking_exchange)

# subscribe to queue
ranking_log_queue.subscribe(:ack => true) do |msg|
  job = Yajl::Parser.new.parse(msg[:payload])["ranking_job"]
  puts "Received request to compute vouched for #{job["user_id"]} at level #{job["level"]}"
end

# Close client
client.stop