class Term < ActiveRecord::Base
  has_uuid

  validates :name, :presence => true, :uniqueness => true, :length => { :minimum => 1, :maximum => 255 }
  has_many :resource_terms
  has_many :resources, :through => :resource_terms
  has_many :translations
  has_many :phrases, :through => :translations
  has_many :vouches

  with_name_like

  def to_s 
    self.name
  end

  def to_json
    { :id => self.id, :name => self.name}.to_json
  end
end
