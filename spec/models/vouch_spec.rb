require 'spec_helper'
require 'ruby-debug'

describe Vouch do


  it_should_behave_like "it has_uuid"
  it_should_behave_like "it has_search_type"

  let(:current_scope) { :pending_my_confirmation }
  it_should_behave_like "it has_scope" do
    let(:current_scope) { :pending_my_confirmation }
  end

  it_should_behave_like "it has_scope" do
    let(:current_scope) { :granted }
  end

  it_should_behave_like "it has_scope" do
    let(:current_scope) { :requested }
  end

  it "should have a scope name after querying the scope" do
    usr = Factory.create(:user)
    5.times do
      usr.vouches_requested<< Factory.create(:vouch)
    end
  end

  describe "statefulness" do
    it "should have initial state of requested" do 
      vouch = Factory.create(:vouch)
      vouch.current_state.should eql :requested
    end

    it "should be able to change state from requested to rejected" do 
      vouch = Factory.create(:vouch)
      vouch.reject!
      vouch.current_state.should eql :rejected
    end

    it "should be able to change state from requested to confirmed" do 
      vouch = Factory.create(:vouch)
      vouch.confirm!
      vouch.current_state.should eql :confirmed
    end

#    it "should be able to change state from confirmed to rejected" do 
#      vouch = Factory.create(:vouch)
#      vouch.confirm!
#      vouch.current_state.should eql :confirmed
#      vouch.reject!
#     vouch.current_state.should eql :rejected
#    end
  end
end
