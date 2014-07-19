require "matrix"
require 'fileutils'

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

namespace :rank do 

  desc "Generate Pagerank Test"
  task :pageranktest => :environment do


    #First, you construct an adjacency matrix. An adjacency matrix is just a matrix of what is linking to what.

    #[0, 1, 1, 1, 1, 0, 1]
    #[1, 0, 0, 0, 0, 0, 0]
    #[1, 1, 0, 0, 0, 0, 0] 
    #[0, 1, 1, 0, 1, 0, 0]
    #[1, 0, 1, 1, 0, 1, 0]
    #[1, 0, 0, 0, 1, 0, 0]
    #[0, 0, 0, 0, 1, 0, 0]

    #This example is based on the wikipedia description, http://en.wikipedia.org/wiki/PageRank#Algorithm

    #So, for example, row 1 is what Page ID=1 is linking to, ie, pages 2, 3, 4, 5, and 7.

    #Let's call the matrix m1,

#    m1 = Matrix[[ 0.0,1.0,1.0,1.0,1.0,0.0,1.0],[1.0,0.0,0.0,0.0,0.0,0.0,0.0],[1.0,1.0,0.0,0.0,0.0,0.0,0.0],[0.0,1.0,1.0,0.0,1.0,0.0,0.0],[1.0,0.0,1.0,1.0,0.0,1.0,0.0],[1.0,0.0,0.0,0.0,1.0,0.0,0.0],[0.0,0.0,0.0,0.0,1.0,0.0,0.0]]

#   #no one links to #6
    m1 = Matrix[[ 0.0,1.0,1.0,1.0,1.0,0.0,0.0],[1.0,0.0,0.0,0.0,0.0,0.0,0.0],[1.0,1.0,0.0,0.0,0.0,0.0,0.0],[0.0,1.0,1.0,0.0,1.0,0.0,0.0],[1.0,0.0,1.0,1.0,0.0,1.0,0.0],[1.0,0.0,0.0,0.0,1.0,0.0,0.0],[0.0,0.0,0.0,0.0,1.0,0.0,0.0]]

#    #6 Links to no one.
#    m1 = Matrix[[ 0.0,1.0,1.0,1.0,1.0,0.0,1.0],[1.0,0.0,0.0,0.0,0.0,0.0,0.0],[1.0,1.0,0.0,0.0,0.0,0.0,0.0],[0.0,1.0,1.0,0.0,1.0,0.0,0.0],[1.0,0.0,1.0,1.0,0.0,1.0,0.0],[1.0,0.0,0.0,0.0,1.0,0.0,0.0],[0.0,0.0,0.0,0.0,0.0,0.0,0.0]]

    #I've got it in floating point so it'll end up in floating point... 

    #Now, the first thing you need to do is compute the row-stochastic matrix, which is the same thing as getting each row to add up to 1.



    #You'd end up with a matrix like this: 

    puts row_stochastic(m1)

    #[[0.0, 0.2, 0.2, 0.2, 0.2, 0.0, 0.2]
    #[1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    #[0.5, 0.5, 0.0, 0.0, 0.0, 0.0, 0.0]
    #[0.0, 0.33, 0.33, 0.0, 0.33, 0.0, 0.0]
    #[0.25, 0.0, 0.25, 0.25 , 0.0, 0.25, 0.0]
    #[0.5, 0.0, 0.0, 0.0, 0.5, 0.0, 0.0]
    #[0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0]]

    #Now, you need to transpose it before you continue.

    row_stochastic(m1).transpose

    #Now, you've got to compute the principal eigenvector. I won't go in to the details of what that is, but here's the method, and #what it returns. 



    puts eigenvector(row_stochastic(m1).transpose)

    #[[1.0], [0.547368421052632], [0.463157894736842], [0.347368421052632], [0.589473684210526], [0.147368421052632], [0.2 ]]

    #Now, just normalize it, by having it all add up to 1.



    #Giving, in the end, 

    puts normalize(eigenvector(row_stochastic(m1).transpose))

    #[[0.303514376996805], [0.166134185303514], [0.140575079872204], [0.105431309904153], [0.178913738019169], [0.0447284345047923 ], #[0.060702875399361]]

  end


  desc "Generate Pagerank"
  task :pagerank => :environment do
  @users = User.find_by_sql("SELECT id
                             FROM (
                             SELECT grantor_id AS id
                             FROM vouches
                             GROUP BY grantor_id
                             UNION
                             SELECT requester_id AS id
                             FROM vouches
                             GROUP BY requester_id
                             ) AS Users
                           GROUP BY id
                           ORDER BY id
                           ")

    @values = Array.new

    @users.each do |u| 
      @vouches = Vouch.find_by_sql("SELECT COALESCE(V.value,0.0) AS id
                                      FROM (SELECT user_id
                                        FROM (
                                          SELECT grantor_id AS user_id
                                          FROM vouches
                                          GROUP BY grantor_id
                                          UNION
                                          SELECT requester_id AS user_id
                                          FROM vouches
                                          GROUP BY requester_id
                                          ) AS Users
                                        GROUP BY user_id
                                        ORDER BY user_id
                                        ) AS U
                                      LEFT JOIN 
                                       (SELECT requester_id AS user_id, 1.0 AS value
                                          FROM vouches
                                          WHERE grantor_id = '#{u.id}'
                                          GROUP BY requester_id) AS V ON V.user_id = U.user_id
                                    ORDER BY U.user_id")

     @values << @vouches.collect{|x| x.id.to_f }

    end

    #puts @values.inspect
    m1 = Matrix.rows(@values)
    pageranks = normalize(eigenvector(row_stochastic(m1).transpose)).to_a
    my_file = File.new("#{Rails.root}/pageranks.csv", "a")

    @users.each_with_index do |u, i| 
      my_file.puts """" + u.id + """," + pageranks[i].to_s
    end

# Run in command line like this to speed it up
# jruby -J-Xmx20G -S rake rank:pagerank

#Run in sql
#create table pagerank (user_id varchar(36), pgvalue float(22,20));

#LOAD DATA LOCAL INFILE '/home/eric/websites/dev.getvouched.com/pageranks.csv' 
#INTO TABLE pagerank 
#FIELDS TERMINATED BY ',' 
#LINES TERMINATED BY '\n' 
#(user_id, pgvalue);


#Just to get some idea of what is going on.
#SELECT user_id, pgvalue, nbr_of_vouches_received, nbr_of_vouches_given
#FROM pagerank
#LEFT JOIN (
#  SELECT requester_id, count(*) as nbr_of_vouches_received
#  FROM vouches
#  GROUP BY requester_id) AS V on pagerank.user_id = V.requester_id
#LEFT JOIN (
#  SELECT grantor_id, count(*) as nbr_of_vouches_given
#  FROM vouches
#  GROUP BY grantor_id) AS V2 on pagerank.user_id = V2.grantor_id
#ORDER by pgvalue DESC
#LIMIT 20;

  end

  desc "Generate Pagerank for each Term"
  task :pagerankterm => :environment do

    @terms = Term.find_by_sql("SELECT V.id FROM (SELECT term_id AS id, MAX(created_at) AS created_at FROM vouches GROUP BY term_id) AS V INNER JOIN terms AS T ON V.id = T.id WHERE V.created_at > T.ranked_at")
    @terms.each_with_index do |t, i|
      puts "On Term: #{i + 1} out of #{@terms.size}"
      @users = User.find_by_sql("SELECT id
                                 FROM (
                                 SELECT grantor_id AS id
                                 FROM vouches
                                 WHERE term_id = '#{t.id}'
                                 GROUP BY grantor_id
                                 UNION
                                 SELECT requester_id AS id
                                 FROM vouches
                                 WHERE term_id = '#{t.id}'
                                 GROUP BY requester_id
                                 ) AS Users
                               GROUP BY id
                              ORDER BY id")
      @values = Array.new

      @users.each do |u| 
        @vouches = Vouch.find_by_sql("SELECT U.user_id, COALESCE(V.value, 0) AS id
                                      FROM (SELECT user_id
                                        FROM (
                                          SELECT grantor_id AS user_id
                                          FROM vouches
                                          WHERE term_id = '#{t.id}'
                                          GROUP BY grantor_id
                                          UNION
                                          SELECT requester_id AS user_id
                                          FROM vouches
                                          WHERE term_id = '#{t.id}'
                                          GROUP BY requester_id
                                          ) AS Users
                                        GROUP BY user_id
                                        ORDER BY user_id
                                        ) AS U
                                      LEFT JOIN 
                                       (SELECT requester_id AS user_id, 1 AS value
                                          FROM vouches
                                          WHERE term_id = '#{t.id}'
                                          AND grantor_id = '#{u.id}'
                                          GROUP BY requester_id) AS V ON V.user_id = U.user_id
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
        resource_term = ResourceTerm.where("resource_id = '#{u.id}' AND term_id = '#{t.id}'").first
        unless resource_term.nil?
          resource_term.term_rank = pageranks[i][0]  
          resource_term.save
       end
      end
    end

  end

end 

