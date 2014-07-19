Factory.define :contact do |c|
  c.association :user
  c.association :identity
  c.name  { Forgery(:name).full_name }
  c.email { Forgery(:internet).email_address }
end
