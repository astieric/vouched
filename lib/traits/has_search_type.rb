class ActiveRecord::Base
  def self.has_search_type
    def search_type
        self.class.to_s.downcase
    end
  end
end
