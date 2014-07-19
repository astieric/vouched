class Subindustry < ActiveRecord::Base
  has_search_type

  validates :name, :presence => true, :length => { :maximum => 200 }
  validates :industry_id, :presence => true

  belongs_to :industry

  searchable do
    string  :search_type, :stored => true
    text    :name,        :stored => true 
    integer :industry_id, :references => Industry
  end

end
