# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :education do |f|
  f.association :resource, :factory => :user
  f.school_name "MyString"
  f.degree "MyString"
  f.field_of_study "MyString"
  f.activities "MyString"
  f.start_year 2010
  f.start_month 1
  f.end_year 2010
  f.end_month 12
  f.association :provider
  f.association :school
end
