class List < ActiveRecord::Base
  has_uuid

  validates :name,         :presence => true, :length => { :maximum => 50 }
  validates :list_type_id, :presence => true
  validates :user_id,      :presence => true, :length => { :minimum => 36, :maximum =>  36 }

  belongs_to :list_type
  belongs_to :user     #This is the user who is the Owner of the list
  belongs_to :resource, :polymorphic => true #This is who/what the list applies to

  has_many :resource_lists
end
