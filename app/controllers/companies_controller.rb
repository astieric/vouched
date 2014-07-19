class CompaniesController < InheritedResources::Base
  access_control do
    allow all, :to => [:show]
    allow :admin
  end
end