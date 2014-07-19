class CreateSchools < ActiveRecord::Migration
  def self.up
    create_table :schools do |t|
      t.string :name,        :limit => 200, :null => false
      t.string :website,     :limit => 100, :null => false
      t.integer :country_id,                :null => false
      t.integer :region_id
      t.timestamps
    end

    add_index :schools, :name
    add_index :schools, :country_id
    add_index :schools, :region_id
  end

  def self.down
    drop_table :schools
  end
end
