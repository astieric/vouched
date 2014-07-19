class ActiveRecord::Base
  def self.has_vouches_given
    has_many :vouches_given   , :as => :grantor   , :dependent => :destroy , :class_name => "Vouch"
  end
end
