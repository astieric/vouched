Factory.define :company do |c|
  c.name         { Forgery(:name).company_name }
  c.website      { "http://www." + Forgery(:name).company_name.downcase + ".com" }
  c.phone        { Forgery(:address).phone }
  c.address      { Forgery(:address).street_address }
  c.city_name    { Forgery(:address).city }
  c.state        { Forgery(:address).state_abbrev }
  c.zip          { Forgery(:address).zip }
  c.country_name { Forgery(:address).country }
  c.association :industry
  c.association :subindustry
  c.association :city
  c.association :region
  c.association :country
end