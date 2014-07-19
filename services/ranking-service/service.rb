require 'rubygems'
require 'yajl'
require 'active_record'
require 'action_pack'
require 'sinatra'
require 'redis'
require 'bunny'

require 'set'

require_relative 'models/term.rb'
require_relative 'models/user.rb'
require_relative 'models/ranking_job.rb'
require_relative 'models/rank_job.rb'

class Service < Sinatra::Base  
    client = Bunny.new(:host => "localhost", :logging => true)

    # start a communication session with the amqp server
    client.start

    # declare queues
    ranking_log_queue  = Bunny::Queue.new(client, "ranking_log_queue",  :durable => true)
    ranking_work_queue = Bunny::Queue.new(client, "ranking_work_queue", :durable => true)
    rank_log_queue     = Bunny::Queue.new(client, "rank_log_queue",     :durable => true)
    rank_work_queue    = Bunny::Queue.new(client, "rank_work_queue",    :durable => true)
    import_log_queue   = Bunny::Queue.new(client, "import_log_queue",   :durable => true)
    import_work_queue  = Bunny::Queue.new(client, "import_work_queue",  :durable => true)

    # create fanout exchanges
    ranking_exchange   = client.exchange("ranking", :type => :fanout,   :durable => true)
    rank_exchange      = client.exchange("rank",    :type => :fanout,   :durable => true)
    import_exchange    = client.exchange("import",  :type => :fanout,   :durable => true)

    # bind the queues to the exchange
    ranking_log_queue.bind(ranking_exchange)
    ranking_work_queue.bind(ranking_exchange)
    rank_log_queue.bind(rank_exchange)
    rank_work_queue.bind(rank_exchange)
    import_log_queue.bind(import_exchange)
    import_work_queue.bind(import_exchange)

  configure do
    env = ENV["SINATRA_ENV"] || "development"
    databases = YAML.load_file("config/database.yml")
    ActiveRecord::Base.establish_connection(databases[env])


    if env == "development"
      TWITTER_ID       = 'We0LCUEQcEkbKgI5ndp2yg'
      TWITTER_SECRET   = 'TkPQ2RpqvGkJ4B7MD0GB1k8xwqWq5Yll89NnoXjXKA'
      FACEBOOK_ID      = '114372748598923'
      FACEBOOK_SECRET  = 'd73b23b13df95a368c88ce34c4aeb81c'
      GITHUB_ID        = '05ff24be8c780887a210'
      GITHUB_SECRET    = 'fadd2231f9c60f56e74f72a291e1ac20964fc587'
      LINKED_IN_ID     = 'd-nIOVnS_ngahsfM1_DrKxh2Pp3iIvMymJYAXlHg165rNTgNMVXuLE6jccSHxDVA'
      LINKED_IN_SECRET = 'ecugeCTONAFf8WxVgf_iRBdsK0qmk7rTNf1oLSZnOHuUzE796iYpCRfqIrQ-ewnY'
    else
      TWITTER_ID       = 'We0LCUEQcEkbKgI5ndp2yg'
      TWITTER_SECRET   = 'TkPQ2RpqvGkJ4B7MD0GB1k8xwqWq5Yll89NnoXjXKA'
      FACEBOOK_ID      = '114372748598923'
      FACEBOOK_SECRET  = 'd73b23b13df95a368c88ce34c4aeb81c'
      GITHUB_ID        = 'e096058fe0358fcba21b'
      GITHUB_SECRET    = '7378792ce9cd3a32ba80a4c73e923fc14148d65d'
      LINKED_IN_ID     = 'd-nIOVnS_ngahsfM1_DrKxh2Pp3iIvMymJYAXlHg165rNTgNMVXuLE6jccSHxDVA'
      LINKED_IN_SECRET = 'ecugeCTONAFf8WxVgf_iRBdsK0qmk7rTNf1oLSZnOHuUzE796iYpCRfqIrQ-ewnY'
    end

  end
    
  before do
    content_type :json
  end

  # create a request to store vouched users by level
  post '/api/v1/vouched/:user_id/:level' do
    begin
      puts "user_id :  #{params["user_id"]}, level: #{ params["level"]}"
       
      job = RankingJob.create_or_update(:user_id => params["user_id"], :level => params["level"])
      ActiveRecord::Base.connection_pool.release_connection
      
      if job.valid? && job.started == false
        ranking_exchange.publish(job.to_json)
        return job.to_json
      else
        error 400, job.errors.to_json
      end
    rescue => e
      # log it and return an error
      puts e.inspect
      error 500, e.message.to_json
    end
  end
  
  # create a ranking request
  post '/api/v1/ranking' do
    begin
      params = Yajl::Parser.new.parse(request.body.read)

      # Geohash Radius
      # 78  K = 48  Miles  = 3 Hash Length  
      # 20  K = 12  Miles  = 4 Hash Length  
      # 2.4 K =  1.5 Miles = 5 Hash Length  
      
      location   = params["geo_hash"]  || "9q8yyk8yuv5x" # San Francisco, CA, USA as Default Location
      radius     = params["radius"]    || 3              # 50 Miles as Default Radius
      limit      = params["limit"]     || 100            # 100 Users as Default Limit
      offset     = params["offset"]    || 0              # 0 Default Offset
      unlocated  = params["unlocated"] || 1              # 1 Default include users with no locations

      locations = ( GeoHash.neighbors(location[0,radius]) << location[0,radius] )

    puts "I'm here"

    if unlocated == 0     
      users = User.find_by_sql("
        SELECT U.id, COUNT(*) AS term_count, SUM(RT.term_rank) AS term_rank
        FROM Users AS U
        INNER JOIN Resource_Terms AS RT ON U.id = RT.resource_id
        WHERE RT.term_id IN ( #{params["terms"].collect{|x| "'" + x + "'"}.join(", ")} )
        AND substring(U.geo_hash, 1,#{radius}) IN ( #{locations.collect{|x| "'" + x + "'"}.join(", ")} )
        GROUP BY U.id
        ORDER BY SUM(RT.term_rank) DESC")
    else
      users = User.find_by_sql("
        SELECT U.id, COUNT(*) AS term_count, SUM(RT.term_rank) AS term_rank
        FROM Users AS U
        INNER JOIN Resource_Terms AS RT ON U.id = RT.resource_id
        WHERE RT.term_id IN ( #{params["terms"].collect{|x| "'" + x + "'"}.join(", ")} )
        AND (substring(U.geo_hash, 1,#{radius}) IN ( #{locations.collect{|x| "'" + x + "'"}.join(", ")} )
          OR U.geo_hash IS NULL)
        GROUP BY U.id
        ORDER BY SUM(RT.term_rank) DESC")
    end

      ActiveRecord::Base.connection_pool.release_connection

      unless params["user_id"].nil?
        # Adjust term_rank

        # Convert @ users into a hash where the key is the user_id

        users_hash = Hash[users.map { |r| [r[:id], r] }]
        # {1=>{:id=>1, :foo=>"bar"}, 2=>{:id=>2, :foo=>"another bar"}} 

        users_set = users.collect{|u| u.id}.to_set

        redis = Redis.new

        # use INCR <ranking_users> to get a unique key.
        ruc = redis.incr('ranking_users_counter').to_s

        # Create a new Set that stores the @users in this set <ranking_users_id>
        u.collect {|u| redis.sadd ruc, u }

        # We want to perform a SINTERSTORE <ranking_users_id>:vouched2 users:<user_id>:vouched2 <ranking_users_id> into a new Set <ranking_users_id>:vouched2.
        # Then we want to reduce <ranking_users_id> with SDIFFSTORE <ranking_users_id> <ranking_users_id> <ranking_users_id>:vouched2 
        # We want to repeat this step 4 times from vouched2 to vouched5.
        2.upto(5) do  |i| 
          redis.multi do  #do this atomically
            redis.sinterstore(ruc + ":vouched#{i}", "users:#{params["user_id"]}:vouched#{i}", ruc)
            redis.sdiffstore(ruc, ruc, ruc + ":vouched#{i}") 
          end
        end

        # Then we retrive the array of SMEMBERS <ranking_users_id>:vouchedX
        # if the vouched2_set includes users[each] then the term_rank * a multiplier (2, 1.75,1.5,1.25)
        # WE MAY NEED TO PLAY WITH THE DAMPENING FACTOR HERE.
        # delete the temp keys after using them.
        # repeat for 3-5
        2.upto(5) do  |i| 
          redis.smembers(ruc + ":vouched#{i}").map { |m| users_hash[m].term_rank = (users_hash[m].term_rank * (10 - i) * 0.25) if users_hash.has_key?(m) }
          redis.del(ruc + ":vouched#{i}")
        end

        users.each do |u|
          u.term_rank = users_hash[u.id].term_rank
        end

      end
      return users.to_json

    rescue => e
      # log it and return an error
      error 500, e.message.to_json
    end

  end

  # create a rank request
  put '/api/v1/ranks/:term_id' do
    begin
      rank = RankJob.create_or_update(:term_id => params["term_id"])
      ActiveRecord::Base.connection_pool.release_connection      

      if rank.valid? && rank.started == false
        rank_exchange.publish(rank.term_id)
        return rank.to_json
      else
        error 400, rank.errors.to_json
      end
    rescue => e
      # log it and return an error
      error 500, e.message.to_json
    end
  end

  # create a bulk rank request
  put '/api/v1/ranks' do
    begin
      ranks = Array.new
      @terms = Term.find_by_sql("SELECT V.id FROM (SELECT term_id AS id, MAX(created_at) AS created_at FROM vouches GROUP BY term_id) AS V INNER JOIN terms AS T ON V.id = T.id WHERE V.created_at > T.ranked_at order by T.name")

      @terms.each do |t|
        rank = RankJob.create_or_update(:term_id => t.id)
        ActiveRecord::Base.connection_pool.release_connection     

        if rank.valid?
          rank_exchange.publish(rank.term_id)
          ranks << rank
        else
          error 400, rank.errors.to_json
        end
      end 
      return ranks.to_json

    rescue => e
      # log it and return an error
      error 500, e.message.to_json
    end
  end

  put '/api/v1/import/:type/:user_id' do

    puts "*********************************"
    puts params.inspect
    puts request.body.read.inspect
    begin
      params.merge!(Yajl::Parser.new.parse(request.body.read)) unless request.body.read.empty?

      import_exchange.publish(params.to_json)
    rescue => e
      # log it and return an error
      error 500, e.message.to_json
    end
    return params.to_json
  end

end