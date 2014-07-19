class CreateCities < ActiveRecord::Migration
  def self.up
    create_table :cities do |t|
      t.integer :country_id, :null => false
      t.integer :region_id,  :null => false
      t.string  :name,       :null => false, :limit => 50
      t.string  :latitude,   :limit => 10
      t.string  :longitude,  :limit => 10
    end

    add_index :cities, :name
  end

  def self.down
    drop_table :cities
  end
end
