Factory.define :archetype do |a|
  a.name        { Forgery(:basic).text :at_least => 7, :at_most => 15, :allow_upper => false, :allow_numeric => false }
  a.abstract    { Forgery(:lorem_ipsum).paragraph }
  a.public      false
  a.description { Forgery(:lorem_ipsum).paragraphs(3) }
  a.user        { |u| u.association :user }
end

Factory.define :archetype_with_two_terms, :class => Archetype do |a|
  a.name        { Forgery(:basic).text :at_least => 7, :at_most => 15, :allow_upper => false, :allow_numeric => false }
  a.abstract    { Forgery(:lorem_ipsum).paragraph }
  a.public      false
  a.description { Forgery(:lorem_ipsum).paragraphs(3) }
  a.user        { |u| u.association :user }
  a.terms       { |terms| [ terms.association(:term), terms.association(:term) ] }
end

Factory.define :archetype_with_requested_vouches, :class => Archetype do |a|
  a.name        { Forgery(:basic).text :at_least => 7, :at_most => 15, :allow_upper => false, :allow_numeric => false }
  a.abstract    { Forgery(:lorem_ipsum).paragraph }
  a.public      false
  a.description { Forgery(:lorem_ipsum).paragraphs(3) }
  a.user        { |u| u.association :user }
  a.vouches_requested { |vouches_requested| [ vouches_requested.association(:vouch), vouches_requested.association(:vouch)] }
end

Factory.define :archetype_name_starts_with_ru, :class => Archetype do |a|
  a.name        { Forgery(:basic).text :at_least => 7, :at_most => 15, :allow_upper => false, :allow_numeric => false }
  a.abstract    { Forgery(:lorem_ipsum).paragraph }
  a.public      false
  a.description { Forgery(:lorem_ipsum).paragraphs(3) }
  a.user        { |u| u.association :user }
end
