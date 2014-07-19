Factory.define :list do |l|
  l.name        { Forgery(:basic).text :at_least => 7, :at_most => 15, :allow_upper => false, :allow_numeric => false }
  l.association :list_type, :factory => :list_type
  l.association :user
end

Factory.define :list_with_two_resources do |l|
  l.name        { Forgery(:basic).text :at_least => 7, :at_most => 15, :allow_upper => false, :allow_numeric => false }
  l.association :list_type, :factory => :list_type
  l.association :user
  l.resource_lists  { |resource_lists| [ resource_lists.association(:resource_list), resource_lists.association(:resource_list) ] }
end

Factory.define :list_with_parent do |l|
  l.name        { Forgery(:basic).text :at_least => 7, :at_most => 15, :allow_upper => false, :allow_numeric => false }
  l.association :list_type, :factory => :list_type
  l.association :user 
  l.association :resource, :factory => :user 
  l.association :resource, :factory => :identity 
  l.association :resource, :factory => :archetype
  l.association :resource, :factory => :job
end

Factory.define :list_with_parent_and_two_resources do |l|
  l.name        { Forgery(:basic).text :at_least => 7, :at_most => 15, :allow_upper => false, :allow_numeric => false }
  l.association :list_type, :factory => :list_type
  l.association :user 
  l.association :resource, :factory => :user 
  l.association :resource, :factory => :identity 
  l.association :resource, :factory => :archetype
  l.association :resource, :factory => :job
  l.resource_lists  { |resource_lists| [ resource_lists.association(:resource_list), resource_lists.association(:resource_list) ] }
end