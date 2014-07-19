class CreateOauthConsumerTokens < ActiveRecord::Migration
  def self.up
    
    create_table :consumer_tokens , :id => false do |t|
      t.string  :id,      :limit =>   36, :null => false
      t.string :user_id,  :limit =>   36
      t.string :type,     :limit =>   30
      t.string :token,    :limit => 1024 # This has to be huge because of Yahoo's excessively large tokens
      t.string :secret
      t.timestamps
    end

    add_index :consumer_tokens, :id,       :unique => true
    add_index :consumer_tokens, :user_id
  end

  def self.down
    drop_table :consumer_tokens
  end

end
