Factory.define :region do |r|
  r.sequence(:id) { |n| n}
  r.name          { Forgery(:address).state        }
  r.code          { Forgery(:address).state_abbrev }
  r.geo_hash             { Forgery(:basic).text :at_least => 12, :at_most => 12, :allow_upper => false, :allow_numeric => true }
  r.association :country
end