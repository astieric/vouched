class ListTypesController < InheritedResources::Base
  access_control do
    allow :admin
  end
end
