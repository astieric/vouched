Factory.define :country do |c|
  c.sequence(:id)        { |n| n}
  c.sequence(:shortname) { |n| Forgery(:address).country + " #{n}" }
  c.sequence(:fullname)  { |n| Forgery(:address).country + " #{n}" }
  c.code                 { Forgery(:internet).cctld  }
  c.isonumber            { Forgery(:basic).number    }
  c.geo_hash             { Forgery(:basic).text :at_least => 12, :at_most => 12, :allow_upper => false, :allow_numeric => true }
end