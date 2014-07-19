Factory.define :school do |s|
  s.sequence(:name) {|n| "My School #{n}"}
  s.sequence(:website) {|n| "http://www.myschool#{n}.edu"}
  s.association :region
  s.association :country
end