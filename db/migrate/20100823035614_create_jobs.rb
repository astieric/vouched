class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs , :id => false do |t|
      t.string   :id,           :null => false, :limit => 36
      t.string   :title,        :null => false
      t.text     :description,  :null => false
      t.string   :city_name,    :null => false
      t.string   :state_code,   :null => false
      t.string   :country_code, :null => false
      t.string   :url,          :limit => 4000
      t.string   :employer,     :null => false
      t.string   :guid,         :null => false

      t.integer  :status_id,    :null => false, :default => 1
      t.integer  :term_count,   :null => false, :default => 0
      t.string   :user_id,	    :null => false, :limit => 36
      t.integer  :country_id
      t.integer  :region_id
      t.integer  :city_id
      t.integer  :company_id
      t.timestamps
    end
  
    add_index :jobs, :id,          :unique => true
    add_index :jobs, :guid,        :unique => true
    add_index :jobs, :user_id
    add_index :jobs, :country_id
    add_index :jobs, :region_id
    add_index :jobs, :city_id
    add_index :jobs, :company_id
  end

  def self.down
    drop_table :jobs
  end
end
