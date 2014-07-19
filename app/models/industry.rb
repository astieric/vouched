class Industry < ActiveRecord::Base
  has_search_type

  validates :name, :presence => true, :uniqueness => true, :length => { :maximum => 200 }

  has_many :subindustries

  searchable do
    string  :search_type, :stored => true
    text    :name,        :stored => true 
  end

end
