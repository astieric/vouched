class CreateTerms < ActiveRecord::Migration
  def self.up
    create_table :terms, :id => false do |t|
      t.string   :id,                   :limit => 36,   :null => false
      t.string   :name,                                 :null => false
      t.integer  :resource_count,       :default => 0
      t.datetime :ranked_at,            :default => '1970-01-01 00:00:00', :null => false
      t.timestamps
    end

    add_index :terms, :name,   :unique => true
  end

  def self.down
    drop_table :terms
  end
end
