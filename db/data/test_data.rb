require 'forgery'

1000.times do |i|
  User.create! :username => i.to_s + '-' + Forgery(:internet).user_name, :email => i.to_s + Forgery(:internet).email_address, :password => Forgery(:basic).password
end


1000.times do |i|
  user = User.where(["username like ?", i.to_s + '-%']).first
  puts i.to_s 
  User.where(["username like ?", '%-%']).order("random()").limit(1 + rand(25)).each do |u|
    Term.limit(1 + rand(10)).order("random()").each do |t|
      @vouch = Vouch.create! :status_id => "confirmed", :requester_id => u.id, :requester_type => "User", :grantor_id => user.id, :grantor_type => "User", :term_id => t.id
        resource_term = @vouch.term.resource_terms.new 
        resource_term.resource_id = @vouch.requester_id
        resource_term.resource_type = @vouch.requester_type
        resource_term.save
    end
  end
end

1000.times do |i|
  user = User.where(["username like ?", i.to_s + '-%']).first
  puts i.to_s 
  Archetype.where(["name like ?", '%' + (i = Kernel.rand(62); i += ((i < 10) ? 48 : ((i < 36) ? 55 : 61 ))).chr + '%']).order("random()").limit(1 + rand(25)).each do |u|
    Term.limit(1 + rand(10)).order("random()").each do |t|
      Vouch.create! :status_id => "confirmd", :requester_id => u.id, :requester_type => "Archetype", :grantor_id => user.id, :grantor_type => "User", :term_id => t.id
    end
  end
end
