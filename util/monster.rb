require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'facets'

# file to save to
my_file  = File.new("/home/max/websites/getvouched.com/util/monster-cat.txt", "a")
my_file2 = File.new("/home/max/websites/getvouched.com/util/monster-subcat.txt", "a")
my_file3 = File.new("/home/max/websites/getvouched.com/util/monster-pro.txt", "a")
my_file4 = File.new("/home/max/websites/getvouched.com/util/monster-pro-skills.txt", "a")


	url = "http://my.monster.com/job-profiles/Browse.aspx"

	doc = Nokogiri::HTML(open(url))
	puts url
       category = 1
	doc.css("#bpLinkBox a").each do |item|
	next if item[:href].nil?
		print category.to_s
              print "," 
              print item.text
              print "," 
              puts item[:href]  

		my_file.print category.to_s
              my_file.print "," 
              my_file.print item.text
              my_file.print "," 
              my_file.puts item[:href]  

		doc2 = Nokogiri::HTML(open(item[:href].to_s))
		subcategory = category * 100 + 1

		doc2.css(".double a").each do |item2|
			my_file2.print subcategory.to_s
	              my_file2.print "," 
	              my_file2.print item2.text
	              my_file2.print "," 
	              my_file2.puts item2[:href]  
 
			doc3 = Nokogiri::HTML(open(item2[:href].to_s))

			profile = subcategory * 100 + 1

			doc3.css(".double a").each do |item3|
				my_file3.print profile.to_s
		              my_file3.print "," 
		              my_file3.print item3.text
		              my_file3.print "," 
		              my_file3.puts item3[:href]  

				doc4 = Nokogiri::HTML(open(item3[:href].to_s))
			
				doc4.css(".ltSkills").each do |item4|
					my_file4.print profile.to_s
			              my_file4.print "," 
					my_file4.puts item4.text
				end
				sleep(1)

	  	              profile = profile + 1
	              end

 	              subcategory = subcategory + 1
              end

              category = category + 1
	end
