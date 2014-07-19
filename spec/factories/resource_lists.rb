Factory.define :resource_list do |rl|
  rl.association :list,     :factory => :list
  rl.association :resource, :factory => :user 
  rl.association :resource, :factory => :identity 
  rl.association :resource, :factory => :archetype
  rl.association :resource, :factory => :job
  rl.sequence(:position) { Forgery(:basic).number } 
end
