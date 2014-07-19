class CreateVersions < ActiveRecord::Migration
  def self.up
    create_table :versions do |t|
      t.string   :item_type, :null => false
      t.string   :item_id,   :null => false, :limit => 36 
      t.string   :event,     :null => false
      t.string   :whodunnit
      t.text     :object
      t.datetime :created_at
    end

    add_index :versions, [:item_type, :item_id]
  end

  def self.down
    drop_table :versions
  end
end
