class ActiveRecord::Base
  def self.with_name_like
    scope :with_name_like, lambda { |name| { :select => [ :id, :name ], :conditions => ['lower(name) like ?', %(%#{name.downcase}%) ], :limit => 7 }}
  end
end
