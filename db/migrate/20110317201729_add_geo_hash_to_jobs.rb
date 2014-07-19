class AddGeoHashToJobs < ActiveRecord::Migration
  def self.up
    add_column :jobs, :geo_hash, :string, :limit => 12
  end

  def self.down
    remove_column :jobs, :geo_hash
  end

end
