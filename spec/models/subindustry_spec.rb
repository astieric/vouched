require 'spec_helper'

describe Subindustry do
  before(:each) do
    Factory.create(:subindustry)
  end

  should_validate_presence_of :name
  should_validate_length_of :name, :maximum => 200
  should_belong_to :industry

  it_should_behave_like "it has_search_type"
  it "should be searchable" do
    Subindustry.should be_searchable
  end

end
