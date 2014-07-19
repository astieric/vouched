class ActiveRecord::Base
  def self.has_lists
    has_many :resource_lists, :as => :resource
    has_many :member_lists, :through => :resource_lists, :class_name => "List", :source => :list
    has_many :applied_lists,  :as => :resource, :class_name => "List"
  end
end
