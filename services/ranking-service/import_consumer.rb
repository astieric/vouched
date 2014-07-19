require 'rubygems'
require 'yajl'
require 'active_record'
require 'bunny'
require 'fbgraph'
require 'twitter'
require 'linkedin'
require 'oauth'
require 'portablecontacts'
require 'uuidtools'
require 'httparty'

require_relative 'lib/traits/has_uuid.rb'
require_relative 'models/user.rb'
require_relative 'models/contact.rb'
require_relative 'models/identity.rb'
require_relative 'models/employment.rb'
require_relative 'models/education.rb'
require_relative 'models/resource_term.rb'

env = ENV["SINATRA_ENV"] || "development"
databases = YAML.load_file("config/database.yml")
ActiveRecord::Base.establish_connection(databases[env])

client = Bunny.new(:host => "localhost", :logging => false)

# start a communication session with the amqp server
client.start

# create/get queue
import_work_queue = client.queue('import_work_queue')

# create/get exchange
import_exchange = client.exchange("import", :type => :fanout, :durable => true)

# bind queue to exchange
import_work_queue.bind(import_exchange)

puts "Import Consumer started... #{import_work_queue.message_count} messages in queue."

# subscribe to queue
import_work_queue.subscribe(:ack => true) do |msg|
  begin
    params = Yajl::Parser.new.parse(msg[:payload])
    puts "*********************************"
    puts params.inspect
    case params["type"]
      when "Google"
        @new_contacts = Contact.google_import(User.find_by_id(params["user_id"]))
      when "Yahoo"
        @new_contacts = Contact.yahoo_import(User.find_by_id(params["user_id"]))
      when "Live"
        @new_contacts = Contact.live_import(User.find_by_id(params["user_id"]), params[:request].request_parameters)
      when "Twitter"
        @new_contacts = Contact.twitter_import(User.find_by_id(params["user_id"]))
      when "Facebook"
        @new_contacts = Contact.facebook_import(User.find_by_id(params["user_id"]))
      when "Linked In"
        @new_contacts = Contact.linked_in_import(User.find_by_id(params["user_id"]))
    end

  rescue Exception => e
    puts "crapped out #{e.inspect}"
    import_exchange.publish(params.to_json)
  end

  ActiveRecord::Base.connection_pool.release_connection
end

# Close client
client.stop