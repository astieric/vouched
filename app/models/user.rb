class User < ActiveRecord::Base
  include Gravtastic
  has_uuid
  has_terms
  has_vouches
  has_lists
  has_messages
  has_search_type

  has_friendly_id :username

  after_create :create_identity, :create_node

  is_gravtastic!  :size => 48

  has_many :archetypes
  has_many :identities
  has_many :jobs
  has_many :recommended_jobs
  has_many :job_recommendations, :through => :recommended_jobs, :source => :job
  has_many :lists
  has_many :contacts
  has_many :educations, :as => :resource
  has_many :employments, :as => :resource

  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable

  has_one :google, :class_name=>"GoogleToken", :dependent=>:destroy #added for oauth services
  has_one :yahoo, :class_name=>"YahooToken", :dependent=>:destroy #added for oauth services

  belongs_to :location, :polymorphic => true

  acts_as_authorization_subject  :association_name => :roles

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me

  validates_presence_of :username, :email, :password
  validates_uniqueness_of :username, :email

  searchable do
    string :search_type, :stored => true
    string :username,     :stored => true 
    text   :email,        :stored => true 
    time   :created_at,   :trie => true
    time   :updated_at,   :trie => true
    string :identities,   :multiple => true do
      identities.map { |identity| identity.email } unless identities.blank?
    end
    string :terms,       :multiple => true do
      terms.map { |term| term.name } unless terms.blank?
    end
  end

  def create_identity
    Identity.find_or_create_by_email(self.email, {:provider_id => 1}).save if self.valid?
  end

  def create_node
    if self.valid?
      #user_node = JSON.parse RestClient.post( "http://localhost:8988/neo4jr-social/nodes", :user_id => self.id  )
      #self.user_node = user_node["node_id"]
      self.save
    end
  end

  def name
    username
  end

  def picture
     self.gravatar_url
  end

  def is? user
    (user == self)
  end

end
