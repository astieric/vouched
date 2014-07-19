require 'rubygems'
require 'active_record'
require 'matrix'
require 'bunny'

require 'models/user.rb'
require 'models/vouch.rb'
require 'models/resource_term.rb'
require 'models/term.rb'
require 'models/rank_job.rb'

    def row_stochastic(matrix)
      x = 0
      row_total = []
      while x < matrix.row_size
        y = 0
        row_total << 0
        while y < matrix.row_size
          row_total[x] += matrix.row(x)[y]
          y += 1
        end
        x += 1
      end
      a1 = matrix.to_a
      x = 0
      while x < matrix.row_size
        y = 0
        while y < matrix.row_size
          a1[x][y] = a1[x][y]/row_total[x]
          y += 1
        end
        x += 1
      end
      Matrix[*a1]
    end

    def eigenvector(matrix)
     i = 0
     a = []
     while i < matrix.row_size
       a << [1]
       i += 1
     end
     eigen_vector = Matrix[*a]
     i = 0
     while i < 100
       eigen_vector = matrix*eigen_vector 
       eigen_vector = eigen_vector / eigen_vector.row(0)[0]
       i += 1
     end
     eigen_vector
    end

    def normalize(matrix)
      i = 0
      t = 0
      while i < matrix.row_size
        t += matrix.column(0)[i]
        i += 1
      end
      matrix = matrix/t 
    end



env = ENV["SINATRA_ENV"] || "development"
databases = YAML.load_file("config/database.yml")
ActiveRecord::Base.establish_connection(databases[env])

client = Bunny.new(:host => "localhost", :logging => false)

# start a communication session with the amqp server
client.start

# create/get queue
rank_work_queue = client.queue('rank_work_queue')

# create/get exchange
rank_exchange = client.exchange("rank", :type => :fanout, :durable => true)

# bind queue to exchange
rank_work_queue.bind(rank_exchange)

# subscribe to queue
rank_work_queue.subscribe(:ack => true) do |msg|

begin
  rank = RankJob.where(:term_id => msg[:payload], :started => false, :finished => false).first
  rank.started = true
  rank.requests = 0
  rank.save

  term = Term.where(:id => msg[:payload]).first
  term.ranked_at = Time.now

  @users = User.find_by_sql("SELECT id
                             FROM (
                             SELECT grantor_id AS id
                             FROM vouches
                             WHERE term_id = '#{msg[:payload]}'
                               AND grantor_type = 'User'
                               AND requester_type = 'User'
                             GROUP BY grantor_id
                             UNION
                             SELECT requester_id AS id
                             FROM vouches
                             WHERE term_id = '#{msg[:payload]}'
                               AND grantor_type = 'User'
                               AND requester_type = 'User'
                             GROUP BY requester_id
                             ) AS Users
                           GROUP BY id
                          ORDER BY id")

  puts "Working on request to rank #{term.name}, found #{@users.size} users to process."

  @values = Array.new

  @users.each do |u| 
    @vouches = Vouch.find_by_sql("SELECT U.user_id, COALESCE(V.value, 0) AS id
                                  FROM (SELECT user_id
                                    FROM (
                                      SELECT grantor_id AS user_id
                                      FROM vouches
                                      WHERE term_id = '#{msg[:payload]}'
                                        AND grantor_type = 'User'
                                        AND requester_type = 'User'
                                      GROUP BY grantor_id
                                      UNION
                                      SELECT requester_id AS user_id
                                      FROM vouches
                                      WHERE term_id = '#{msg[:payload]}'
                                        AND grantor_type = 'User'
                                        AND requester_type = 'User'
                                      GROUP BY requester_id
                                      ) AS Users
                                    GROUP BY user_id
                                    ORDER BY user_id
                                    ) AS U
                                  LEFT JOIN 
                                   (SELECT requester_id AS user_id, 1 AS value
                                      FROM vouches
                                      WHERE term_id = '#{msg[:payload]}'
                                      AND grantor_id = '#{u.id}'
                                      AND grantor_type = 'User'
                                      AND requester_type = 'User'
                                    ) AS V ON V.user_id = U.user_id
                                 ORDER BY U.user_id")

   if @vouches.inject(0){|sum,item| sum + item.id.to_i} == 0
     @values << @vouches.collect! {|x| 1.0 }
   else
     @values << @vouches.collect{|x| x.id.to_f }
   end

  end

  m1 = Matrix.rows(@values)
  pageranks = normalize(eigenvector(row_stochastic(m1).transpose)).to_a

  @users.each_with_index do |u, i| 
    resource_term = ResourceTerm.where("resource_id = '#{u.id}' AND term_id = '#{msg[:payload]}'").first
    unless resource_term.nil?
      resource_term.term_rank = pageranks[i][0]  
      resource_term.save
    end
  end

  rank = RankJob.where(:term_id => msg[:payload], :started => true, :finished => false).first
  rank.finished = true
  rank.save

  # save the ranked_at time we got when the process started
  term.save

  # if more rank requests came in while still processing, add them to the work queue.
  if rank.requests > 0
    RankJob.create_or_update(:term_id => rank.term_id)
    rank_exchange.publish(rank.term_id)
  end

rescue Exception => e
  rank.started = false
  rank.finished = false
  rank.save
  rank_exchange.publish(rank.term_id)
end

ActiveRecord::Base.connection_pool.release_connection
end

# Close client
client.stop