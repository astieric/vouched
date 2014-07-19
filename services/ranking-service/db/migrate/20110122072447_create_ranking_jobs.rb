class CreateRankingJobs < ActiveRecord::Migration
  def self.up
    create_table :ranking_jobs do |t|
      t.string  :user_id,      :limit => 36,      :null => false
      t.integer :level,        :default => 1,     :null => false
      t.boolean :started,      :default => false, :null => false
      t.boolean :finished,     :default => false, :null => false
      t.integer :requests,     :default => 1,     :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :ranking_jobs
  end
end
