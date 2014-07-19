require 'spec_helper'

describe ListType do
  before(:each) do
    Factory.create(:list_type)
  end

  should_validate_presence_of :name
  should_validate_uniqueness_of :name
  should_validate_length_of :name, :maximum => 50
  should_have_many :lists
end
