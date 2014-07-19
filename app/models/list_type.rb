class ListType < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true, :length => { :maximum => 50 }
  has_many :lists
end
