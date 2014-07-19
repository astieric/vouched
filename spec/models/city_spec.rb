require 'spec_helper'

describe City do
  before(:each) do
    Factory.create(:city)
  end

  should_validate_presence_of :name
  should_validate_length_of :name, :maximum => 50

  should_belong_to :country
  should_belong_to :region

  it_should_behave_like "it has_search_type"
  it "should be searchable" do
    City.should be_searchable
  end
  it_should_behave_like "it has_coordinates"

end
