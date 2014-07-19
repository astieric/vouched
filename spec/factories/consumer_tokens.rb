Factory.define :consumer_token do |ct|
  ct.association :user
  ct.type   { Forgery(:basic).text :at_least => 10, :at_most => 30 }
  ct.token  { Forgery(:basic).text :at_least => 255, :at_most => 1024 }
  ct.secret { Forgery(:basic).text :at_least => 255, :at_most => 255 }
end