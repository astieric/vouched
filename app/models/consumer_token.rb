require 'oauth/models/consumers/token'
class ConsumerToken < ActiveRecord::Base
  has_uuid
  include Oauth::Models::Consumers::Token
  belongs_to :user
 
end
