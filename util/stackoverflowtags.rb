require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'facets'

# file to save to
my_file = File.new("/home/max/websites/getvouched.com/util/taglist.txt", "a")

(1..418).each do |i|

	# Get a Nokogiri::HTML:Document for the page we.re interested in...
	url = "http://stackoverflow.com/tags?page=#{i}"

	doc = Nokogiri::HTML(open(url))
	puts url
#	puts doc.at_css("title").text
	doc.css(".post-tag").each do |item|
#		puts item.children.text
		my_file.puts item.children.text
	end
sleep(1)
end