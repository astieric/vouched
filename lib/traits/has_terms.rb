class ActiveRecord::Base
  def self.has_terms
    has_many :resource_terms, :as => :resource
    has_many :terms, :through => :resource_terms, :class_name => "Term"
    accepts_nested_attributes_for :terms, :allow_destroy => false, :reject_if => proc { |attrs| attrs['name'].blank? }
  end
end
