class CreateListTypes < ActiveRecord::Migration
  def self.up
    create_table :list_types do |t|
      t.string :name,        :null => false, :limit => 50
    end

    add_index :list_types, :name
  end

  def self.down
    drop_table :list_types
  end
end
