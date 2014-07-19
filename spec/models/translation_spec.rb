require 'spec_helper'

describe Translation do
  should_belong_to :phrase
  should_belong_to :term
end
