Factory.define :user do |u|
  u.username     { Forgery(:basic).text :at_least => 7, :at_most => 12, :allow_upper => false, :allow_numeric => true} 
  u.email        { Forgery(:internet).email_address }
  u.password     { Forgery(:basic).password }
end

Factory.define :user_with_requested_vouches, :class => User do |u|
  u.username     { Forgery(:basic).text :at_least => 7, :at_most => 12, :allow_upper => false, :allow_numeric => true} 
  u.email        { Forgery(:internet).email_address }
  u.password     { Forgery(:basic).password }
  u.vouches_requested { |vouches_requested| [ vouches_requested.association(:vouch), vouches_requested.association(:vouch)] }
end

Factory.define :user_with_given_vouches, :class => User do |u|
  u.username     { Forgery(:basic).text :at_least => 7, :at_most => 12, :allow_upper => false, :allow_numeric => true} 
  u.email        { Forgery(:internet).email_address }
  u.password     { Forgery(:basic).password }
  u.vouches_given { |vouches_given| [ vouches_given.association(:vouch), vouches_given.association(:vouch)] }
end

Factory.define :user_with_two_terms, :class => User do |u|
  u.username     { Forgery(:basic).text :at_least => 7, :at_most => 12, :allow_upper => false, :allow_numeric => true} 
  u.email        { Forgery(:internet).email_address }
  u.password     { Forgery(:basic).password }
  u.terms        { |terms| [ terms.association(:term), terms.association(:term) ] }
end
