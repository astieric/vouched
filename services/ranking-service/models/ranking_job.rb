class RankingJob < ActiveRecord::Base
  validates :user_id, :presence => true
  validates :level,   :presence => true, :numericality => true

  def self.create_or_update(attributes)
    ranking_job = RankingJob.where(:user_id => attributes[:user_id], :level => attributes[:level], :finished => false).first
    if ranking_job 
      ranking_job.requests = ranking_job.requests + 1
      ranking_job.save
      ranking_job
    else
      RankingJob.create(attributes)
    end
  end
end
