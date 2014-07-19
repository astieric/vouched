Factory.define :list_type do |lt|
  lt.name        { Forgery(:basic).text :at_least => 7, :at_most => 15, :allow_upper => false, :allow_numeric => false }
end

Factory.define :list_type_with_lists do |lt|
  lt.name        { Forgery(:basic).text :at_least => 7, :at_most => 15, :allow_upper => false, :allow_numeric => false }
  lt.lists       { |lists| [ lists.association(:list), lists.association(:list)] }
end