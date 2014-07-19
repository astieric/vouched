class TranslationsController < InheritedResources::Base
  belongs_to :term
  belongs_to :phrase

  access_control do
    allow :admin
  end
end
