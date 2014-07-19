class CreateLists < ActiveRecord::Migration
  def self.up
    create_table :lists , :id => false do |t|
      t.string  :id,                    :limit => 36,      :null => false
      t.string  :name,                  :limit => 50,      :null => false 
      t.integer :list_type_id,                             :null => false 
      t.string  :user_id,               :limit => 36,      :null => false  
      t.boolean :public,                :default => false, :null => false
      t.string  :resource_id,           :limit => 36 
      t.string  :resource_type,         :limit => 20 

      t.timestamps
    end

    add_index :lists, :id,              :unique => true
    add_index :lists, :name
    add_index :lists, [:user_id, :list_type_id]
    add_index :lists, [:resource_id]
  end

  def self.down
    drop_table :lists
  end
end
