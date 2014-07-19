class CreateEmployments < ActiveRecord::Migration
  def self.up
    create_table :employments , :id => false do |t|
      t.string  :id,           :null => false, :limit => 36
      t.string  :resource_id,   :limit => 36
      t.string  :resource_type, :limit => 20
      t.string  :title
      t.string  :summary
      t.integer :start_year
      t.integer :start_month
      t.integer :end_year
      t.integer :end_month
      t.boolean :is_current,        :default=>false
      t.string  :company_name,      :limit => 200
      t.integer :company_id
      t.integer :provider_id,	:default => 0
      t.timestamps
    end

    add_index :employments, :resource_id
    add_index :employments, :company_id

  end

  def self.down
    drop_table :employments
  end
end
