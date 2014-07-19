class Provider < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true, :length => { :maximum => 255 }

  has_many :identities
  has_many :employments
  has_many :educations

end