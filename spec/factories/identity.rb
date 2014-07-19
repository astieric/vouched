Factory.define :identity do |i|
  i.user      { |u| u.association :user }
  i.email     { Forgery(:internet).email_address }
end

Factory.define :identity_with_requested_vouches, :class => Identity do |i|
  i.user      { |u| u.association :user }
  i.email     { Forgery(:internet).email_address }
  i.vouches_requested { |vouches_requested| [ vouches_requested.association(:vouch), vouches_requested.association(:vouch)] }
end

Factory.define :identity_with_given_vouches, :class => Identity do |i|
  i.user      { |u| u.association :user }
  i.email     { Forgery(:internet).email_address }
  i.vouches_given { |vouches_given| [ vouches_given.association(:vouch), vouches_given.association(:vouch)] }
end

Factory.define :identity_with_two_terms, :class => Identity do |i|
  i.user      { |u| u.association :user }
  i.email     { Forgery(:internet).email_address }
  i.terms     { |terms| [ terms.association(:term), terms.association(:term) ] }
end

Factory.define :empty_identity, :class => Identity do |i|
  i.user      { |u| u.association :user }
end
