class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages , :id => false do |t|
      t.string   :id,               :null => false, :limit => 36
      t.string   :sender_id,        :null => false
      t.string   :sender_type,      :null => false
      t.text     :subject
      t.text     :body
      t.string   :state,            :null => false
      t.datetime :hidden_at
      t.string   :type
      t.timestamps
    end

    add_index :messages, :id,       :unique => true
  end

  def self.down
    drop_table :messages
  end
end
