# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :employment do |f|
  f.association :resource, :factory => :user
  f.title "My Job Title"
  f.summary "My Job Summary"
  f.start_year 2010
  f.start_month 1
  f.end_year 2010
  f.end_month 12
  f.is_current false
  f.company_name { Forgery(:name).company_name }
  f.association :provider
  f.association :company
end
