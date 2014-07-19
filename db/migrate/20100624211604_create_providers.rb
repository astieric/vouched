class CreateProviders < ActiveRecord::Migration
  def self.up
    create_table :providers do |t|
      t.string :name, :null => false, :limit => 255
    end

    add_index :providers, :name, :unique => true
  end

  def self.down
    drop_table :providers
  end
end
