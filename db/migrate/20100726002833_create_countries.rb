class CreateCountries < ActiveRecord::Migration
  def self.up
    create_table :countries do |t|
      t.string  :code,      :limit =>  10, :null => false
      t.string  :shortname, :limit =>  50, :null => false
      t.string  :fullname,  :limit => 100, :null => false
      t.integer :isonumber
      t.string  :latitude,  :limit => 10
      t.string  :longitude, :limit => 10

    end

    add_index :countries, :shortname, :unique => true
    add_index :countries, :fullname,  :unique => true
  end

  def self.down
    drop_table :countries
  end
end
