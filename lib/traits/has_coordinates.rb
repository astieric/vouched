class ActiveRecord::Base
  def self.has_coordinates

    def coordinates
      if ["City","Region","Country"].include?(self.class.to_s)
        #GeoHash.encode(self.latitude.to_f, self.longitude.to_f) 
        self.geo_hash #We have already precalculated the geo_hash
      else
        location = (self.respond_to?('city') ? self.city : nil || self.region || self.country)
        location.respond_to?('coordinates') ? location.coordinates : ""
      end
    end

  end
end
