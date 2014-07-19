class AddGeoHashToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :geo_hash, :string, :limit => 12
    add_column :users, :location_id, :integer
    add_column :users, :location_type, :string, :limit => 10
    add_column :users, :radius, :integer
  end

  def self.down
    remove_column :users, :geo_hash
    remove_column :users, :location_id
    remove_column :users, :location_type
    remove_column :users, :radius
  end
end
