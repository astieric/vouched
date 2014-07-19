Factory.define :city do |c|
  c.name { Forgery(:address).city }
  c.geo_hash             { Forgery(:basic).text :at_least => 12, :at_most => 12, :allow_upper => false, :allow_numeric => true }
  c.association :region
  c.association :country
end