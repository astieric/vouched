class Company < ActiveRecord::Base
  has_search_type
  has_coordinates

  validates :name	,     :length => { :maximum => 200 }, :presence => true
  validates :website	,     :length => { :maximum => 200 }
  validates :phone	,     :length => { :minimum =>   3  , :maximum => 50 }
  validates :address ,     :length => { :maximum => 200 }
  validates :city_name,    :length => { :maximum => 100 }
  validates :state	,     :length => { :maximum => 100 }
  validates :zip	,     :length => { :maximum =>  50 }
  validates :country_name, :length => { :maximum => 100 }

  belongs_to :industry
  belongs_to :subindustry
  belongs_to :country
  belongs_to :region
  belongs_to :city

  has_many :employments

  searchable do
    string  :search_type,     :stored => true
    string  :coordinates 
    text    :name,            :stored => true 
    text    :website,         :stored => true 
    text    :phone,           :stored => true 
    text    :address,         :stored => true 
    text    :city_name,       :stored => true 
    text    :state,           :stored => true 
    text    :zip,             :stored => true 
    text    :country_name,    :stored => true 
    integer :industry_id,     :references => Industry
    integer :subindustry_id,  :references => Subindustry
    integer :city_id,         :references => City
    integer :region_id,       :references => Region
    integer :country_id,      :references => Country
    time    :created_at,      :trie => true
    time    :updated_at,      :trie => true
  end

end
