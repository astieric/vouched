class AddGeoHashToCountries < ActiveRecord::Migration
  def self.up
    add_column :countries, :geo_hash, :string, :limit => 12
  end

  def self.down
    remove_column :countries, :geo_hash
  end
end
