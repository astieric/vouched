class CreateSubindustries < ActiveRecord::Migration
  def self.up
    create_table :subindustries do |t|
      t.string :name,         :limit => 200
      t.integer :industry_id, :null => false
    end

    add_index :subindustries, :name
    add_index :subindustries, :industry_id
  end

  def self.down
    drop_table :subindustries
  end
end
