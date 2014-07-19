Factory.define :provider do |p|
  p.name        { Forgery(:basic).text :at_least => 7, :at_most => 15, :allow_upper => false, :allow_numeric => false }
end