# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :phrase do |f|
  f.name { Forgery(:basic).text :at_least => 7, :at_most => 50, :allow_upper => true, :allow_numeric => false }
end
