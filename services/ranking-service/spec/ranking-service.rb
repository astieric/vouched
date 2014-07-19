require File.dirname(__FILE__) + '/spec_helper'

describe "My App" do
  include Rack::Test::Methods

  def app
    @app ||= Service
  end

  it "should return 404 when page cannot be found" do
    get '/404'
    last_response.status.should == 404
  end

  it "should return term a list of users" do
     post '/api/v1/ranking', {:text => "lorem ipsum Ruby lorem ipsum", :priority =>1}.to_json
     last_response.should be_ok
     last_response.body.should include("")
  end

end