require "spec_helper"

describe SubindustriesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/industries/1/subindustries" }.should route_to(:controller => "subindustries", :action => "index", :industry_id => "1")
    end

    it "recognizes and generates #new" do
      { :get => "/industries/1/subindustries/new" }.should route_to(:controller => "subindustries", :action => "new", :industry_id => "1")
    end

    it "recognizes and generates #show" do
      { :get => "/industries/1/subindustries/1" }.should route_to(:controller => "subindustries", :action => "show", :id => "1", :industry_id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/industries/1/subindustries/1/edit" }.should route_to(:controller => "subindustries", :action => "edit", :id => "1", :industry_id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/industries/1/subindustries" }.should route_to(:controller => "subindustries", :action => "create", :industry_id => "1")
    end

    it "recognizes and generates #update" do
      { :put => "/industries/1/subindustries/1" }.should route_to(:controller => "subindustries", :action => "update", :id => "1", :industry_id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/industries/1/subindustries/1" }.should route_to(:controller => "subindustries", :action => "destroy", :id => "1", :industry_id => "1")
    end

  end
end
