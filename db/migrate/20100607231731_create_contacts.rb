class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts , :id => false do |t|
      t.string :id,                 :limit =>  36, :null => false
      t.string :user_id,            :limit =>  36, :null => false	
      t.string :identity_id,        :limit =>  36, :null => false	
      t.string :name,               :limit => 255
      t.string :email,              :limit => 255
      t.timestamps
    end

    add_index :contacts, :id,                 :unique => true
    add_index :contacts, :name,               :unique => false
    add_index :contacts, :email,              :unique => false
    add_index :contacts, :user_id,            :unique => false
  end

  def self.down
    drop_table :contacts
  end
end
