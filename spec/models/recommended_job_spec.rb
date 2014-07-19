require 'spec_helper'

describe RecommendedJob do
  should_belong_to :user
  should_belong_to :job

  should_validate_presence_of :job_rank
  should_validate_numericality_of :job_rank, :only_integer => true, :greater_than => 0

  should_validate_presence_of :term_count
  should_validate_numericality_of :term_count, :only_integer => true, :greater_than => 0



end
