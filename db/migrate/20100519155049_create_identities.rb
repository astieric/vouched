class CreateIdentities < ActiveRecord::Migration
  def self.up
    create_table :identities , :id => false do |t|
      t.string  :id,               :limit =>  36, :null => false
      t.string  :user_id,		:limit =>  36		 
      t.string  :name,		:limit => 255
      t.string  :nickname,		:limit => 255
      t.string  :url,              :limit => 255
      t.string  :email,		:limit => 255
      t.integer :provider_id,	:default => 1

      t.string :token,             :limit => 1024 # This has to be huge because of Yahoo's excessively large tokens
      t.string :secret
      t.string :picture_url

      t.integer :term_count,       :default => 0
      t.integer :user_node
      t.integer :identity_node

      t.confirmable
      t.timestamps
    end

    add_index :identities, :id,                  :unique => true
    add_index :identities, :confirmation_token,  :unique => true
    add_index :identities, :provider_id
    add_index :identities, :user_id
    add_index :identities, [:email, :provider_id], :unique => true
    add_index :identities, :name
    add_index :identities, :nickname
    add_index :identities, :user_node
    add_index :identities, :identity_node
  end

  def self.down
    drop_table :identities
  end
end
