class Country < ActiveRecord::Base
  has_search_type
  has_coordinates 

  has_many :users, :as => :location

  validates :code,      :presence => true,                      :length => { :maximum =>  10 }
  validates :shortname, :presence => true, :uniqueness => true, :length => { :maximum =>  50 }
  validates :fullname,  :presence => true, :uniqueness => true, :length => { :maximum => 100 }

  has_many :cities
  has_many :regions

  searchable do
    string  :search_type, :stored => true
    string  :coordinates 
    text    :shortname,   :stored => true 
    text    :fullname,    :stored => true 
    text    :code,        :stored => true 
  end

end
