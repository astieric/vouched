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

  it "should return term for Ruby when extacting from text" do
     post '/api/v1/extractions', {:text => "lorem ipsum Ruby lorem ipsum", :priority =>1}.to_json
     last_response.should be_ok
     last_response.body.should include("6d65fbc8-fe56-11df-af1e-003048c3cf84")
  end

  it "should return terms for Ruby, Ruby on Rails and Java when extacting from text" do
     post '/api/v1/extractions', '{"text":"lorem ipsum Ruby on Rails and Java lorem ipsum ", "priority":1}'
      last_response.should be_ok
     last_response.body.should include("6cc151a4-fe56-11df-af1e-003048c3cf84")
     last_response.body.should include("6d65fbc8-fe56-11df-af1e-003048c3cf84")
     last_response.body.should include("6d65ff92-fe56-11df-af1e-003048c3cf84")
  end

end