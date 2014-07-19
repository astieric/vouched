require 'spec_helper'

describe Provider do
  before(:each) do
    Factory.create(:provider)
  end

  should_validate_presence_of :name
  should_validate_length_of :name, :maximum => 255

  should_have_many :identities

  it "should be searchable" do
    Provider.should be_searchable
  end

end
