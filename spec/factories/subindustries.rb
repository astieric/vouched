Factory.define :subindustry do |s|
  s.sequence(:name) {|n| "My Sub Industry #{n}"}
  s.association :industry
end