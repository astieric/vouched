class Phrase < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true, :length => { :minimum => 1, :maximum => 4000 }

  has_many :translations
  has_many :terms, :through => :translations

end
