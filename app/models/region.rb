class Region < ActiveRecord::Base
  has_search_type
  has_coordinates 

  has_many :users, :as => :location

  validates :code, :presence => true,  :length => { :maximum => 10 }
  validates :name, :presence => true,  :length => { :maximum => 100 }
  validates :country_id, :presence => true

  belongs_to :country
  has_many :cities

  searchable do
    string  :search_type, :stored => true
    string  :coordinates 
    text    :name,        :stored => true 
    text    :code,        :stored => true 
    integer :country_id,  :references => Country
  end

end
