class CreateMessageRecipients < ActiveRecord::Migration
  def self.up
    create_table :message_recipients , :id => false do |t|
      t.string   :id,              :null => false, :limit => 36
      t.string   :message_id,      :null => false, :limit => 36
      t.string   :receiver_id,     :null => false, :limit => 36
      t.string   :receiver_type,   :null => false
      t.string   :kind,            :null => false
      t.integer  :position
      t.string   :state,           :null => false
      t.datetime :hidden_at
    end

    add_index :message_recipients, :id,      :unique => true
    add_index :message_recipients, [:message_id, :kind, :position], :unique => true
  end
  
  def self.down
    drop_table :message_recipients
  end
end
