class SchoolsController < InheritedResources::Base
  belongs_to :country
  belongs_to :region

  access_control do
    allow all, :to => [:show]
    allow :admin
  end
end
