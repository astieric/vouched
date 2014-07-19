namespace :db do 
  namespace :seed do 
    require Rails.root.join('db', 'seed_tables')

    desc "dump the tables holding seed data to db/Rails.env_seed.sql. SEED_TABLES need to be defined in db/seed_tables.rb" 
    # Usage: rake TABLES="vouches,users" db:seed:dump

    task :dump => :environment do |t, args|
      config = ActiveRecord::Base.configurations[Rails.env] 
      tables = ( ENV["TABLES"].nil? ? nil : ENV["TABLES"].split(',') ) || SEED_TABLES
      tables.each do |seed_table|
        dump_cmd = "mysqldump --user=#{config['username']} --password=#{config['password']} #{config['database']} #{seed_table} > db/#{Rails.env}_#{seed_table}_seed.sql" 
        system(dump_cmd) 
      end
    end

    desc "load the dumped seed data from db/(Rails.env)_seed.sql into the database" 
    # Usage: rake TABLES="vouches,users" db:seed:load

    task :load => :environment do 
      config = ActiveRecord::Base.configurations[Rails.env] 
      tables = ( ENV["TABLES"].nil? ? nil : ENV["TABLES"].split(',') ) || SEED_TABLES
      tables.each do |seed_table|
        system("mysql --user=#{config['username']} --password=#{config['password']} #{config['database']} < db/#{Rails.env}_#{seed_table}_seed.sql") 
      end 
    end 

    task :split_tables => :environment do
      exec "scala #{Rails.root}/lib/tasks/splitter.scala"
    end

    task :load_splitted => :environment do 
      config = ActiveRecord::Base.configurations[Rails.env] 
      tables = ( ENV["TABLES"].nil? ? nil : ENV["TABLES"].split(',') ) || SEED_TABLES
      tables.each do |seed_table|
        print "=> Loading dump for table #{seed_table}"
        system("mysql --user=#{config['username']} --password=#{config['password']} #{config['database']} < db/seeds/#{seed_table}.sql") 
      end 
    end 

  end 
end

# Read more: http://www.agileweboperations.com/seed-data-in-ruby-on-rails/#ixzz0ujs58Blp
