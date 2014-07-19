class School < ActiveRecord::Base
  has_search_type
  has_coordinates

  validates :name, :presence => true, :length => { :maximum => 200 }
  validates :website, :presence => true, :length => { :maximum => 100 }
  validates :country_id, :presence => true

  belongs_to :country
  belongs_to :region

  has_many :educations

  searchable do
    string  :search_type,     :stored => true
    string  :coordinates 
    text    :name,            :stored => true 
    text    :website,         :stored => true 
    integer :region_id,       :references => Region
    integer :country_id,      :references => Country
    time    :created_at,      :trie => true
    time    :updated_at,      :trie => true
  end

end
