class City < ActiveRecord::Base
  has_search_type
  has_coordinates

  has_many :users, :as => :location

  validates :name,       :presence => true, :length => { :maximum => 50 }
  validates :country_id, :presence => true
  validates :region_id,  :presence => true

  belongs_to :country
  belongs_to :region

  searchable do
    string  :search_type, :stored => true
    string  :coordinates 
    text    :name,        :stored => true 
    integer :region_id,   :references => Region
    integer :country_id,  :references => Country
  end

end
