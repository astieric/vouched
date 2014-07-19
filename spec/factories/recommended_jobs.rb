# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :recommended_job do |f|
  f.user { |u| u.association :user }
  f.job  { |u| u.association :job }
  f.job_rank   { Forgery(:basic).number :at_most => 25 }
  f.term_count { Forgery(:basic).number :at_most => 50 }
end
