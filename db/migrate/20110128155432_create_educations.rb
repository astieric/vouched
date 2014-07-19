class CreateEducations < ActiveRecord::Migration
  def self.up
    create_table :educations ,  :id => false do |t|
      t.string  :id,            :null => false, :limit => 36
      t.string  :resource_id,   :null => false, :limit => 36
      t.string  :resource_type, :null => false, :limit => 20
      t.string  :school_name
      t.string  :degree
      t.string  :field_of_study
      t.string  :activities		, :limit => 500
      t.integer :start_year
      t.integer :start_month
      t.integer :end_year
      t.integer :end_month
      t.integer :school_id
      t.integer :provider_id,   :null => false, :default => 0
      t.timestamps
    end 

    add_index :educations, :resource_id
    add_index :educations, :school_id

  end

  def self.down
    drop_table :educations
  end
end
