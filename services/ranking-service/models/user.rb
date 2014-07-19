class User < ActiveRecord::Base
  has_many :identities
  has_many :contacts
  has_many :educations, :as => :resource
  has_many :employments, :as => :resource

  has_one :google, :class_name=>"GoogleToken", :dependent=>:destroy #added for oauth services
  has_one :yahoo, :class_name=>"YahooToken", :dependent=>:destroy #added for oauth services

end
