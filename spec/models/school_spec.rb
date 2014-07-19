require 'spec_helper'

describe School do
  before(:each) do
    Factory.create(:school)
  end

  should_validate_presence_of :name
  should_validate_length_of :name, :maximum => 200

  should_validate_presence_of :website
  should_validate_length_of :website, :maximum => 100

  should_belong_to :country
  should_belong_to :region

  it_should_behave_like "it has_search_type"
  it "should be searchable" do
    School.should be_searchable
  end
  it_should_behave_like "it has_coordinates"

end
