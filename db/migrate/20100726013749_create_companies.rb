class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.integer :jigsawid
      t.string  :name,            :limit => 200, :null => false
      t.string  :website,         :limit => 200
      t.string  :phone,           :limit =>  50
      t.string  :address,         :limit => 200
      t.string  :city_name,       :limit => 100
      t.string  :state,           :limit => 100
      t.string  :zip,             :limit =>  50
      t.string  :country_name,    :limit => 100
      t.integer :industry_id
      t.integer :subindustry_id
      t.integer :city_id
      t.integer :region_id
      t.integer :country_id
      t.timestamps
    end

    #Add Indexes to Rake db:seed job after import 
    #add_index :companies, :name
    #add_index :companies, :industry_id
    #add_index :companies, :subindustry_id
    #add_index :companies, :city_id
    #add_index :companies, :region_id
    #add_index :companies, :country_id
  end

  def self.down
    drop_table :companies
  end
end
