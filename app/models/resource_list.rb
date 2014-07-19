class ResourceList < ActiveRecord::Base
  has_uuid

  validates :resource_id , :uniqueness => {:scope => [:list_id], :message => "Already on the list!"}

  belongs_to :resource, :polymorphic => true
  belongs_to :list 
  acts_as_list :scope => :list

end
