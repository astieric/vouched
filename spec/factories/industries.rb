Factory.define :industry do |i|
  i.sequence(:name) {|n| "My Industry #{n}"}
end