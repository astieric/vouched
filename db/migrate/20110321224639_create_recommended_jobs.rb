class CreateRecommendedJobs < ActiveRecord::Migration
  def self.up
    create_table :recommended_jobs,  :id => false do |t|
      t.string  :id,          :limit =>   36, :null => false 
      t.string  :user_id,     :limit =>   36, :null => false
      t.string  :job_id,      :limit =>   36, :null => false
      t.integer :job_rank,                    :null => false
      t.integer :term_count,                  :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :recommended_jobs
  end
end
