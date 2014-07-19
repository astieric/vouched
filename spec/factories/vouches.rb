Factory.define :vouch do |v|
  v.status_id { 1 + rand(2) }
  v.association :term, :factory => :term
end

Factory.define :vouch_with_two_terms, :class => Vouch do |v|
  v.status_id { 1 + rand(2) }
  v.terms       { |terms| [ terms.association(:term), terms.association(:term) ] }
end

Factory.define :vouch_tmp do |v|
  v.association :requester, :factory => :user
  v.association :requester, :factory => :identity
  v.association :grantor, :factory => :user
  v.association :grantor, :factory => :identity
end
