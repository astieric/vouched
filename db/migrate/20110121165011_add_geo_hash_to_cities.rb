class AddGeoHashToCities < ActiveRecord::Migration
  def self.up
    add_column :cities, :geo_hash, :string, :limit => 12
  end

  def self.down
    remove_column :cities, :geo_hash
  end
end
