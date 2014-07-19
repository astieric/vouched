require 'spec_helper'

describe Region do
  before(:each) do
    Factory.create(:region)
  end

  should_validate_presence_of :code
  should_validate_length_of :code, :maximum => 10

  should_validate_presence_of :name
  should_validate_length_of :name, :maximum => 100

  should_belong_to :country
  should_have_many :cities

  it_should_behave_like "it has_search_type"
  it "should be searchable" do
    Region.should be_searchable
  end
  it_should_behave_like "it has_coordinates"

end
