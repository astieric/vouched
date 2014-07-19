Factory.define :job do |j|
  j.title            { Forgery(:basic).text :at_least => 7, :at_most => 255, :allow_numeric => false }
  j.description      { Forgery(:basic).text :at_least => 150, :at_most => 1000, :allow_numeric => false }
  j.city_name        { Forgery(:address).city }
  j.state_code       { Forgery(:address).state_abbrev }
  j.country_code     { Forgery(:internet).cctld  }
  j.employer         { Forgery(:name).company_name }
  j.guid             { Forgery(:basic).text :at_least => 7, :at_most => 255, :allow_numeric => true }
  j.association :user
  j.association :city
  j.association :region
  j.association :country
  j.association :company
end

Factory.define :job_with_two_terms, :class => Job do |j|
  j.title            { Forgery(:basic).text :at_least => 7, :at_most => 255, :allow_numeric => false }
  j.description      { Forgery(:basic).text :at_least => 150, :at_most => 1000, :allow_numeric => false }
  j.city_name        { Forgery(:address).city }
  j.state_code       { Forgery(:address).state_abbrev }
  j.country_code     { Forgery(:internet).cctld  }
  j.employer         { Forgery(:name).company_name }
  j.guid             { Forgery(:basic).text :at_least => 7, :at_most => 255, :allow_numeric => true }
  j.association :user
  j.association :city
  j.association :region
  j.association :country
  j.association :company
  j.terms       { |terms| [ terms.association(:term), terms.association(:term) ] }
end