require 'spec_helper'

describe Country do
  before(:each) do
    Factory.create(:country)
  end

  should_validate_presence_of :code
  should_validate_length_of :code, :maximum => 10

  should_validate_presence_of :shortname
  should_validate_uniqueness_of :shortname
  should_validate_length_of :shortname, :maximum => 50

  should_validate_presence_of :fullname
  should_validate_uniqueness_of :fullname
  should_validate_length_of :fullname, :maximum => 100

  should_have_many :cities
  should_have_many :regions

  it_should_behave_like "it has_search_type"
  it "should be searchable" do
    Country.should be_searchable
  end
  it_should_behave_like "it has_coordinates"

end
