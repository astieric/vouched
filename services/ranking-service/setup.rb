require 'rubygems'
require 'yajl'
require 'active_record'
require 'action_pack'
require 'neography'
require 'httparty'
require 'redis'

require 'models/user.rb'

  env = ENV["SINATRA_ENV"] || "development"
  databases = YAML.load_file("config/database.yml")
  ActiveRecord::Base.establish_connection(databases[env])


  # Clean Database
  @neo = Neography::Rest.new

  last_node = Neography::Node.create().neo_id.to_i
  (1..last_node).each do |node|
    @neo.delete_node!(node)
  end

  # Make sure all users have a user_node
  User.update_all(:user_node => nil)

  @users = User.where("user_node IS NULL")
  
  @users.each do |u|
    u.user_node = Neography::Node.create("user_id" => u.id).neo_id
    u.save
  end

  @vusers = User.find_by_sql("SELECT G.user_node AS grantor_user_node, R.user_node AS requester_user_node
                             FROM Vouches as V
                             INNER JOIN Users as G on V.grantor_id = G.id
                             INNER JOIN Users as R on V.requester_id = R.id
                             WHERE G.user_node <> R.user_node
                             GROUP BY G.user_node, R.user_node")

  @vusers.group_by(&:grantor_user_node).each do |grantor_user_node, requesters|
    grantor_node = Neography::Node.load(grantor_user_node)
    requesters.each do |r|
       puts "Grantor: #{grantor_user_node} vouched for #{r.requester_user_node}"
      grantor_node.outgoing(:vouched) << Neography::Node.load(r.requester_user_node)
    end
  end

  # Give users a location ( different cities in the state of Illinois)
  sql = "UPDATE users
         SET location_type = 'City', location_id = Base.city_id, geo_hash = Base.geo_hash
         FROM (SELECT user_id, city_id, geo_hash
               FROM (
                     SELECT row_number() OVER (ORDER BY id) AS num, id AS user_id
                     FROM users 
                     WHERE location_id IS NULL
                    ) AS U
               INNER JOIN (SELECT row_number() OVER (ORDER BY geo_hash) as num, id AS city_id, geo_hash
                           FROM cities 
                           WHERE country_id = 213 AND region_id = 3987) AS C ON C.num = U.num) AS Base
         WHERE users.id = Base.user_id;"
  User.connection.execute(sql, :skip_logging)



  redis = Redis.new
  redis.flushdb

  options = { :headers => {'Content-Type' => 'application/json', 'Content-Length' => '0'} } 

  @users.each_with_index do |u, i|
    puts "Starting user #{i} at  #{Time.now}"
    (2..6).each do |j|
      HTTParty.post("http://localhost:9292/api/v1/vouched/#{u.id}/#{j}", options)
    end
  end



