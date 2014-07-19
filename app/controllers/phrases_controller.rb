class PhrasesController < InheritedResources::Base
  access_control do
    allow :admin
  end
end
