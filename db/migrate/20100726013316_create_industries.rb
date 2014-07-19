class CreateIndustries < ActiveRecord::Migration
  def self.up
    create_table :industries do |t|
      t.string :name, :limit => 200, :null => false
    end

    add_index :industries, :name, :unique => true
  end

  def self.down
    drop_table :industries
  end
end
