require 'find'
puts '=> Loading Traits'
Find.find("#{Rails.root}/lib/traits/") do |path|
  require(path) if File.basename(path) =~ /\.rb$/
end
