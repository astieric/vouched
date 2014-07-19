class ActiveRecord::Base
  def self.has_vouches
    has_vouches_given
    has_vouches_requested
  end
end
