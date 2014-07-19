class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users , :id => false do |t|
      t.string  :id,             :null => false, :limit => 36
      t.string  :username,       :null => false
      t.integer :user_node
      t.string  :linkedin_token
      t.string  :linkedin_secret
      t.integer :term_count,     :default => 0
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable
      t.token_authenticatable
      t.timestamps
    end

    add_index :users, :id,                     :unique => true
    add_index :users, :email,                  :unique => true
    add_index :users, :username,               :unique => true
    add_index :users, :user_node,              :unique => true
    add_index :users, :reset_password_token,   :unique => true
  end

  def self.down
    drop_table :users
  end
end
