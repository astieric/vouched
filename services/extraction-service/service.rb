require 'rubygems'
require 'yajl'
require 'active_record'
require 'action_pack'
require 'sinatra'

require 'models/term.rb'

class Service < Sinatra::Base  

  configure do
    env = ENV["SINATRA_ENV"] || "development"
    databases = YAML.load_file("config/database.yml")
    ActiveRecord::Base.establish_connection(databases[env])
  end
    
  before do
    content_type :json
  end
  
  # create an extraction request
  post '/api/v1/extractions' do
    begin
          words = Yajl::Parser.new.parse(request.body.read)["text"].downcase.scan(/\w+/)

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

          return Term.select(:id).where(["LOWER(name) IN (?)", one_grams.collect{|w| w[0]} + bi_grams.collect{|w| w[0]} + tri_grams.collect{|w| w[0]} ]).all.to_json

    rescue => e
      # log it and return an error
      error 500, e.message.to_json
    end

    ActiveRecord::Base.connection_pool.release_connection
  end


end