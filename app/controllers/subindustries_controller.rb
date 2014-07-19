class SubindustriesController < InheritedResources::Base
  belongs_to :industry

  access_control do
    allow all, :to => [:show]
    allow :admin
  end
end
