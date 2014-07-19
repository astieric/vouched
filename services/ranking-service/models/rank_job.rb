class RankJob < ActiveRecord::Base
  validates :term_id, :presence => true

  def self.create_or_update(attributes)
    rank = RankJob.where(:term_id => attributes[:term_id], :finished => false).first
    if rank 
      rank.requests = rank.requests + 1
      rank.save
      rank
    else
      RankJob.create(attributes)
    end
  end

end
