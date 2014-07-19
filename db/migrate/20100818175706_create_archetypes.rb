class CreateArchetypes < ActiveRecord::Migration
  def self.up
    create_table :archetypes , :id => false do |t|
      t.string  :id,          :limit =>   36, :null => false
      t.string  :name
      t.string  :abstract,    :limit => 1000
      t.string  :user_id,     :limit =>   36		 
      t.boolean :public,      :default => false
      t.text    :description
      t.integer :term_count,  :default => 0
      t.timestamps
    end

    add_index :archetypes, :id, :unique => true
    add_index :archetypes, :user_id
  end

  def self.down
    drop_table :archetypes
  end
end
