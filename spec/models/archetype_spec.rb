require 'spec_helper'
require 'ruby-debug'

describe Archetype do
  should_belong_to :user

  it_should_behave_like "it has_uuid"
  it_should_behave_like "it has_terms"
  it_should_behave_like "it has_vouches_as_requester"

  it_should_behave_like "it has_search_type"
  it "should be searchable" do
    Archetype.should be_searchable
  end

  it "should have many terms" do
    archetype_with_two_terms = Factory.create(:archetype_with_two_terms)
    archetype_with_two_terms.terms.length.should eql 2
  end

end
