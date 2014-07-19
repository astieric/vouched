class RegionsController < InheritedResources::Base
  belongs_to :country

  access_control do
    allow all, :to => [:show]
    allow :admin
  end
end
