class Job < ActiveRecord::Base
  has_uuid
  has_terms
  has_lists
  has_search_type
  has_coordinates

  belongs_to :user
  belongs_to :country
  belongs_to :region
  belongs_to :city
  belongs_to :company

  #has_many :recommended_jobs
  has_many :recommended_users, :class_name => 'RecommendedJob'
  has_many :user_recommendations, :through => :recommended_users, :source => :user

  validates :title,            :presence => true, :length => { :minimum =>  1, :maximum => 255 }
  validates :description,      :presence => true
  validates :city_name,        :presence => true, :length => { :minimum =>  1, :maximum => 255 }
  validates :state_code,       :presence => true, :length => { :minimum =>  1, :maximum => 255 }
  validates :country_code,     :presence => true, :length => { :minimum =>  1, :maximum => 255 }
  validates :employer,         :presence => true, :length => { :minimum =>  1, :maximum => 255 }
  validates :user_id,          :presence => true, :length => { :minimum => 36, :maximum =>  36 }

  # Solr 
  searchable do
    string  :search_type, :stored => true
    string  :coordinates 
    text    :title,        :stored => true 
    text    :description
    text    :city_name,    :stored => true 
    text    :state_code,   :stored => true 
    text    :country_code, :stored => true 
    text    :employer,     :stored => true 

    string  :user_id,     :references => User
    integer :country_id,  :references => Country
    integer :region_id,   :references => Region
    integer :city_id,     :references => City
    integer :company_id,  :references => Company
    time    :created_at,  :trie => true
    time    :updated_at,  :trie => true

    string :terms, :multiple => true do
      terms.map { |term| term.name }  unless terms.blank?
    end
  end
end
