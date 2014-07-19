class ActiveRecord::Base
  def self.has_vouches_requested
    has_many :vouches_requested , :as => :requester , :dependent => :destroy , :class_name => "Vouch"
  end
end
