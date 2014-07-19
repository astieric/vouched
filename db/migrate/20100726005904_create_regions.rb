class CreateRegions < ActiveRecord::Migration
  def self.up
    create_table :regions do |t|
      t.integer :country_id,  :null => false
      t.string :code,         :null => false, :limit =>  10
      t.string :name,         :null => false, :limit => 100
      t.string  :latitude,    :limit => 10
      t.string  :longitude,   :limit => 10
    end

    add_index :regions, :name
  end

  def self.down
    drop_table :regions
  end
end
