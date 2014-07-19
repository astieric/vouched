class CreateVouches < ActiveRecord::Migration
  def self.up
    create_table :vouches, :id => false do |t|
      t.string  :id,                      :limit => 36,   :null => false
      t.integer :status_id,	              :null => false, :default => 1
      t.string  :requester_id,            :limit => 36 
      t.string  :requester_type,          :limit => 20 
      t.string  :grantor_id,              :limit => 36 
      t.string  :grantor_type,            :limit => 20 
      t.string  :term_id,                 :limit => 36 
      t.timestamps
    end

    add_index :vouches, :id,              :unique => true
    add_index :vouches, :requester_id
    add_index :vouches, :grantor_id
    add_index :vouches, :term_id
    add_index :vouches, [:requester_id, :status_id]
    add_index :vouches, [:grantor_id, :status_id]
  end

  def self.down
    drop_table :vouches
  end
end
