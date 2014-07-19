class CreateResourceTerms < ActiveRecord::Migration
  def self.up
    create_table :resource_terms , :id => false do |t|
      t.string  :id,            :limit => 36,    :null => false
      t.string  :resource_id,   :limit => 36
      t.string  :resource_type, :limit => 20
      t.string  :term_id,       :limit => 36,    :null => false
      t.float   :term_rank,     :default => 0.0, :null => false
    end

    add_index :resource_terms, :id, :unique => true
    add_index :resource_terms, :resource_id
    add_index :resource_terms, :term_id
  end

  def self.down
    drop_table :resource_terms
  end
end
