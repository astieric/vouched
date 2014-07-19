class CreatePhrases < ActiveRecord::Migration
  def self.up
    create_table :phrases do |t|
      t.string   :name,    :limit => 4000
    end

    add_index :phrases, :name
  end

  def self.down
    drop_table :phrases
  end
end
