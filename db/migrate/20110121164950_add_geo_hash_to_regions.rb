class AddGeoHashToRegions < ActiveRecord::Migration
  def self.up
    add_column :regions, :geo_hash, :string, :limit => 12
  end

  def self.down
    remove_column :regions, :geo_hash
  end
end
