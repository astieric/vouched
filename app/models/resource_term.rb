class ResourceTerm < ActiveRecord::Base
  has_uuid

  belongs_to :resource, :polymorphic => true, :counter_cache => :term_count, :dependent => :destroy
  belongs_to :term, :counter_cache => :resource_count, :dependent => :destroy

  validates :term_id , :uniqueness => {:scope => [:resource_id], :message => "we should be adding to vouch_count instead"}
end
