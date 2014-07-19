Factory.define :term do |a|
  a.name        { Forgery(:basic).text :at_least => 7, :at_most => 15, :allow_upper => false, :allow_numeric => false }
end

Factory.define :term_starts_with_ru, :class => Term do |a|
  a.name        { "Ru#{Forgery(:basic).text :at_least => 5, :at_most => 10, :allow_upper => false, :allow_numeric => false}" }
end
