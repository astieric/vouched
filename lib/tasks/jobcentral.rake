namespace :jobcentral do 
  require 'fileutils'
  require 'benchmark'
  require 'httparty'
  require 'json'


  #Call using : jruby -J-Xms8G -J-Xmx48G -S rake jobcentral:oneimport

  desc "Import new jobs from large jobcentral xml file"
  task :oneimport => :environment do
    require 'rubygems'
    require 'set'
    include Java

    #http://marc.rubyforge.org/MARC/LibXMLReader.html#build_record-instance_method
    java.lang.Class.forName("javax.xml.stream.XMLInputFactory")
    include javax.xml.stream       

    module JavaIO     
      include_package "java.io"
    end

    bulk_loader = User.find_by_username("bulk_loader").id
    existing_jobs = Job.select(:guid).readonly(true).all.collect{|x| x.guid}.to_set

    factory = javax.xml.stream.XMLInputFactory.newInstance
    xml_stream = JavaIO::FileInputStream.new("#{Rails.root}/util/jobcentral/xmlfeed.xml")

    reader = factory.createXMLStreamReader(xml_stream)

    def get_element(target, reader) 
      grab_text = false
      while reader.has_next
        case reader.next
          when javax.xml.stream.XMLStreamConstants::START_ELEMENT
            grab_text = true if reader.local_name == target
          when javax.xml.stream.XMLStreamConstants::CHARACTERS
            text = reader.text if grab_text
          when javax.xml.stream.XMLStreamConstants::END_ELEMENT
            break if reader.local_name == target
        end
      end
     text
    end

    counter = 0
    jobs    = []

    while reader.has_next
      case reader.next
      when javax.xml.stream.XMLStreamConstants::START_ELEMENT
        if reader.local_name == "listing"
          h = {}
          %w[id secondary_source url country_code state_code city description title].each do |j|
            h[j.intern] = get_element(j, reader)
          end
          
            #MYSQL jobs << "( UUID(), 
            # XML data is not cleaned before here, so we're brute forcing the import and will clean it up later.
            # We also replace the last 3 digits (102, 105) with our viewsource code which is 1564.
            jobs << "( uuid_generate_v4(),
                        #{Job.connection.quote(h[:title] || "" ) }, 
                        #{Job.connection.quote(h[:description] || "" ) }, 
                        #{Job.connection.quote(h[:city] || "" ) }, 
                        #{Job.connection.quote(h[:state_code] || "" ) }, 
                        #{Job.connection.quote(h[:country_code] || "" ) }, 
                        #{Job.connection.quote(h[:url][0..48] + "1564" || "" ) }, 
                        #{Job.connection.quote(h[:secondary_source] || "" ) }, 
                        #{Job.connection.quote(h[:id])  || "" }, 
                        #{Job.connection.quote(bulk_loader) }, NOW(), NOW() ) " unless h[:id].to_set.subset? existing_jobs
           existing_jobs.add(h[:id])
          
        end
      when javax.xml.stream.XMLStreamConstants::END_ELEMENT
        if reader.local_name == "listing"
          counter = counter + 1
          if (counter % 1000 == 0)
            sql = "INSERT INTO jobs (id, title, description, city_name, state_code, country_code, url, employer, guid, user_id, created_at, updated_at) VALUES "
            sql << jobs.join(',')
            unless jobs.empty?
              Job.connection.execute(sql, :skip_logging)
              jobs = []
              puts "Wrote next 1000 out of #{counter} jobs at #{Time.now}"
            end
          end 
        end
      end
    end

    # Get the leftovers and do the locations.

      unless jobs.empty?
        sql = "INSERT INTO jobs (id, title, description, city_name, state_code, country_code, url, employer, guid, user_id, created_at, updated_at) VALUES "
        sql << jobs.join(',')
        Job.connection.execute(sql, :skip_logging)
      end

      puts "Wrote the last set of #{counter % 1000} jobs at #{Time.now}"

      #MYSQL sql = "UPDATE jobs j LEFT JOIN countries c ON j.country_code = c.code SET j.country_id = c.id WHERE j.country_id IS NULL;"
      sql = "UPDATE jobs SET country_id = c.id FROM countries c WHERE jobs.country_id IS NULL AND jobs.country_code = c.code;"
      Job.connection.execute(sql, :skip_logging)
      puts "Updated the Countries at #{Time.now}"

      #MYSQL sql = "UPDATE jobs j LEFT JOIN regions r ON j.country_id = r.country_id AND j.state_code = r.code SET j.region_id = r.id WHERE j.region_id IS NULL;"
      sql = "UPDATE jobs SET region_id = r.id FROM regions r WHERE jobs.region_id IS NULL AND jobs.country_id = r.country_id AND jobs.state_code = r.code;"

      Job.connection.execute(sql, :skip_logging)
      puts "Updated the Regions at #{Time.now}"

      #MYSQL sql = "UPDATE jobs j LEFT JOIN cities c ON j.country_id = c.country_id AND j.region_id = c.region_id AND j.city_name = c.name SET j.city_id = c.id WHERE j.city_id IS NULL;"
      sql = "UPDATE jobs SET city_id = c.id FROM cities c WHERE jobs.city_id IS NULL AND jobs.country_id = c.country_id AND jobs.region_id = c.region_id AND jobs.city_name = c.name;"

      Job.connection.execute(sql, :skip_logging)
      puts "Updated the Cities at #{Time.now}"

      sql = "UPDATE jobs SET geo_hash = c.geo_hash FROM cities c WHERE jobs.geo_hash IS NULL AND jobs.city_id = c.id;"
      Job.connection.execute(sql, :skip_logging)
      puts "Updated the Jobs in Cities at #{Time.now}"

      sql = "UPDATE jobs SET geo_hash = r.geo_hash FROM regions r WHERE jobs.geo_hash IS NULL AND jobs.region_id = r.id;"
      Job.connection.execute(sql, :skip_logging)
      puts "Updated the Jobs in Regions at #{Time.now}"

      sql = "UPDATE jobs SET geo_hash = c.geo_hash FROM countries c WHERE jobs.geo_hash IS NULL AND jobs.country_id = c.id;"
      Job.connection.execute(sql, :skip_logging)
      puts "Updated the Jobs in Countries at #{Time.now}"
  end # end of oneimport task

  desc "Get the terms for the new jobs"
  task :extract => :environment do
      counter = 0
      terms   = []
      offset = 0
      limit = 1000
      last_id = '0'
      record_count = Job.where(Job.arel_table[:id].gt(last_id)).where(Job.arel_table[:created_at].gteq(1.days.ago)).count
      puts "Processing #{record_count} jobs"

      terms_hash = Hash.new
      Term.select([:id, :name]).all.each{|t| terms_hash[t.name.downcase] = t.id}
      puts "Found #{terms_hash.size} terms"

      while(offset < record_count)
        #Doing this to avoid bloating log file
        records = Job.connection.execute(Job.select([:id, :title, :description]).where(Job.arel_table[:id].gt(last_id)).where(Job.arel_table[:created_at].gteq(1.days.ago)).limit(limit).order(:id).to_sql, :skip_logging).collect{|r| r}
        break if records.first.nil?

        # do actual work here
        records.each do |j|
          words = (j["title"] + " " + j["description"]).downcase.scan(/\w+/)
          one_grams = Hash.new(0) # hash returns a value of zero if key not present 
          bi_grams  = Hash.new(0) 
          tri_grams = Hash.new(0) 
 
          num = words.length 
          num.times {|i| 
            one_grams[words[i]] += 1 
            if i < (num - 1) 
               bi = words[i] + ' ' + words[i+1] 
               bi_grams[bi] += 1 
               if i < (num - 2) 
                  tri = bi + ' ' + words[i+2] 
                  tri_grams[tri] += 1 
               end 
            end 
          }

          extracted_terms = terms_hash.values_at(*one_grams.collect{|w| w[0]} + bi_grams.collect{|w| w[0]} + tri_grams.collect{|w| w[0]} ).compact.uniq

          extracted_terms.each do |t|
            terms << "(uuid_generate_v4(), '#{j["id"]}', 'Job', '#{t}')"
          end

          counter = counter + 1
          if (counter % limit == 0)
            sql = "INSERT INTO resource_terms (id, resource_id, resource_type, term_id) VALUES "
            sql << terms.join(',')
            unless terms.empty?
              ResourceTerm.connection.execute(sql, :skip_logging)
              terms = []
              puts "Inserted the next #{limit} out of #{counter} job terms at #{Time.now}"
            end
          end 
        end

        # end of work
        last_id = records.last["id"]
        offset += limit
      end

      unless terms.empty?
        sql = "INSERT INTO resource_terms (id, resource_id, resource_type, term_id) VALUES "
        sql << terms.join(',')
        ResourceTerm.connection.execute(sql, :skip_logging)
        puts "Inserted the the last set of #{counter % limit} job terms at #{Time.now}"
      end

  end # end of extract task

  desc "Get the recommended users for the new jobs"
  task :recommend => :environment do
      # Geohash Radius
      # 78  K = 48  Miles  = 3 Hash Length  
      # 20  K = 12  Miles  = 4 Hash Length  
      # 2.4 K =  1.5 Miles = 5 Hash Length

      radius = 3 
      user_limit  = 25     # 25 Users as Default Limit

      counter = 0
      recommended_jobs  = []
      offset = 0
      limit = 1000
      last_id = '0'
      record_count = Job.where(Job.arel_table[:id].gt(last_id)).where(Job.arel_table[:created_at].gteq(1.days.ago)).count
      puts "Processing #{record_count} jobs"

      while(offset < record_count)
        #Doing this to avoid bloating log file
        records = Job.connection.execute(Job.select([:id, :geo_hash]).where(Job.arel_table[:id].gt(last_id)).where(Job.arel_table[:updated_at].gteq(1.days.ago)).where(Job.arel_table[:geo_hash].not_eq('')).where(Job.arel_table[:geo_hash].not_eq(nil)).limit(limit).order(:id).to_sql, :skip_logging).collect{|r| r}
        break if records.first.nil?

        # do actual work here
        records.each do |j|
          
          locations = GeoHash.neighbors(j["geo_hash"][0,radius]) << j["geo_hash"][0,radius] 
          sql = "SELECT U.id AS user_id, ROW_NUMBER () OVER ( ORDER BY SUM(RT.term_rank) DESC) AS job_rank, COUNT(*) AS term_count
                 FROM Users AS U
                 INNER JOIN Resource_Terms AS RT ON U.id = RT.resource_id
                 WHERE RT.term_id IN ( SELECT term_id 
                                       FROM Resource_Terms 
                                       WHERE resource_id =  '#{j["id"]}' )
                 AND substring(U.geo_hash, 1, #{radius}) IN ( #{locations.collect{|x| "'" + x + "'"}.join(", ")} )
                 GROUP BY U.id
                 LIMIT #{user_limit}"

          rts = ResourceTerm.connection.execute(sql, :skip_logging).collect{|r| r} 
          rts.each do |rt|
            recommended_jobs << "(uuid_generate_v4(), '#{rt["user_id"]}', '#{j["id"]}', #{rt["job_rank"]}, #{rt["term_count"]}, NOW(), NOW())"
          end

          counter = counter + 1 
          if (counter % limit == 0)
            sql = "INSERT INTO recommended_jobs (id, user_id, job_id, job_rank, term_count, created_at, updated_at) VALUES "
            sql << recommended_jobs.join(',')
            unless recommended_jobs.empty?
              RecommendedJob.connection.execute(sql, :skip_logging)
              recommended_jobs = []
              puts "Inserted the next #{limit} out of #{counter} recommended jobs at #{Time.now}"
            end
          end 
        end

        # end of work
        last_id = records.last["id"]
        offset += limit
      end

      unless recommended_jobs.empty?
        sql = "INSERT INTO recommended_jobs (id, user_id, job_id, job_rank, term_count, created_at, updated_at) VALUES "
        sql << recommended_jobs.join(',')
        RecommendedJob.connection.execute(sql, :skip_logging)
        puts "Inserted the the last set of #{counter % limit} recommended jobs at #{Time.now}"
      end

  end # end of recommend task


  desc "Download the single xml job file from http://xmlfeed.jobcentral.com/xmlfeed.zip" 
  task :onedownload do
    FileUtils.mkdir("#{Rails.root}/util/jobcentral") unless File.exists? "#{Rails.root}/util/jobcentral"
    Dir.chdir("#{Rails.root}/util/jobcentral")

    system("wget -c -N http://xmlfeed.jobcentral.com/xmlfeed.zip") 
    system("rm wget-log*")
    system("unzip xmlfeed.zip")
    system("rm xmlfeed.zip")
  end

  desc "Download the xml job files from http://xmlfeed.jobcentral.com" 
  task :download do
    FileUtils.mkdir("#{Rails.root}/util/jobcentral") unless File.exists? "#{Rails.root}/util/jobcentral"
    Dir.chdir("#{Rails.root}/util/jobcentral")

    # wget         : Use wget to download all files
    # -b           : in the background
    # -c           : continuing if large file download is interrupted
    # -r           : recursively 
    # -l1          : just 1 level down
    # -np          : never going up a directory
    # -A.xml       : only links ending in .xml
    # -nd          : into a single directory
    # -w1          : waiting 1 second between downloads (4500 seconds, 1.5 hours)
    # -N           : that are newer than existing files 
    # -erobots=off : ignoring robots.txt (it's a 404 anyway)
    system("wget -b -c -r -l1 -np -A.xml -nd -w1 -N -erobots=off http://xmlfeed.jobcentral.com") 
    system("rm wget-log*")
  end

  desc "Import new jobs from jobcentral"
  task :import => :environment do
    require 'rubygems'
    require 'libxml'
    require "activerecord-import/mysql"

    @@dotDir = /^\.\.?$/
    bulk_loader = User.find_by_username("bulk_loader").id
    include LibXML
    Dir.foreach("#{Rails.root}/util/jobcentral/") do |entry|
      next if entry =~ @@dotDir
      next if entry == "wget-log"
      parser = XML::Parser.file("#{Rails.root}/util/jobcentral/#{entry}")
      doc, jobs = parser.parse, []
      doc.find('//jobs/job').each do |job|
        h = {}
        %w[title description link imagelink guid expiration_date employer location].each do |j|
          h[j.intern] = job.find(j).first.content
        end
        newjob = Job.new(h) 
        newjob.id = UUIDTools::UUID.timestamp_create.to_s
        newjob.user_id = bulk_loader
        jobs << newjob if Job.find_by_guid(newjob.guid).nil?
      end
    Job.import jobs, :validate => false  
    end # of Dir.foreach
  end

end