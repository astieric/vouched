require 'spec_helper'

describe TermsController do
  before(:each) do
    controller.stub!(:current_user).and_return(
      @current_user = Factory.create(:user)
    )
  end

  it "should respond to autocomplete" do
    5.times { Factory.create :term_starts_with_ru }  
    xhr :post, "autocomplete", :name => 'Ru'
    response.should be_success
    body = JSON.parse response.body
    body.each { |term| 
      (term["term"]["name"].downcase =~ /^ru/).should eql 0
    }
  end
end
