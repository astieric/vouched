require 'spec_helper'

describe Contact do
  before(:each) do
    Factory.create(:contact)
  end

  it_should_behave_like "it has_search_type"
  it "should be searchable" do
    Contact.should be_searchable
  end

  should_validate_presence_of :email
  should_validate_length_of :email, :maximum => 255

  should_belong_to :user
  should_belong_to :identity

  it_should_behave_like "it has_uuid"

end