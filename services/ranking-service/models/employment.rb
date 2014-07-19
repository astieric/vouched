class Employment < ActiveRecord::Base
  has_uuid

  belongs_to :resource, :polymorphic => true
  belongs_to :provider
  belongs_to :company

  scope :imported, where("provider_id > 0").order("provider_id")

  validates_numericality_of :start_year  , :allow_nil => true , :only_integer => true, :less_than_or_equal_to => Time.now.strftime('%Y').to_i, :greater_than_or_equal_to => 1900
  validates_numericality_of :end_year    , :allow_nil => true , :only_integer => true, :less_than_or_equal_to => Time.now.strftime('%Y').to_i, :greater_than_or_equal_to => 1900
  validates_numericality_of :start_month , :allow_nil => true , :only_integer => true, :less_than_or_equal_to => 12, :greater_than_or_equal_to => 1
  validates_numericality_of :end_month   , :allow_nil => true , :only_integer => true, :less_than_or_equal_to => 12, :greater_than_or_equal_to => 1

  validates_length_of :title             , :allow_nil => true , :maximum => 255  
  validates_length_of :summary           , :allow_nil => true , :maximum => 255  
  validates_length_of :company_name      , :allow_nil => true , :maximum => 255  

  validates_presence_of :resource_id
  validates_presence_of :provider_id

end
