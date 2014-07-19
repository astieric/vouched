namespace :generate do 
  require 'fileutils'

  desc "Generate 1000 UUIDs and add them to uuids.txt"
  task :uuids => :environment do

    my_file = File.new("#{Rails.root}/uuids.txt", "a")
    uuids = []
    1000.times do
      uuids << UUIDTools::UUID.timestamp_create.to_s
    end
    my_file.puts uuids
  end
end

