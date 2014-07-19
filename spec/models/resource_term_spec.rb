require 'spec_helper'

describe ResourceTerm do

  should_belong_to :resource, :polymorphic => true
  should_belong_to :term
end
