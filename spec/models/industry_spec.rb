require 'spec_helper'

describe Industry do
  before(:each) do
    Factory.create(:industry)
  end

  should_validate_presence_of :name
  should_validate_uniqueness_of :name
  should_validate_length_of :name, :maximum => 200
  should_have_many :subindustries

  it_should_behave_like "it has_search_type"
  it "should be searchable" do
    Industry.should be_searchable
  end

end
