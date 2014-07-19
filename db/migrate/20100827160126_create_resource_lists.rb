class CreateResourceLists < ActiveRecord::Migration
  def self.up
    create_table :resource_lists , :id => false do |t|
      t.string  :id,            :limit => 36,  :null => false
      t.string  :resource_id,   :limit => 36,  :null => false
      t.string  :resource_type, :limit => 20,  :null => false
      t.string  :list_id,       :limit => 36,  :null => false
      t.integer :position,      :default => 1, :null => false
      t.timestamps
    end

    add_index :resource_lists, :id, :unique => true
    add_index :resource_lists, :resource_id
    add_index :resource_lists, :list_id
    add_index :resource_lists, [:list_id, :resource_id], :unique => true
  end

  def self.down
    drop_table :resource_lists
  end
end
