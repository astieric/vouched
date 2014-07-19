require "spec_helper"

describe EmploymentsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/employments" }.should route_to(:controller => "employments", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/employments/new" }.should route_to(:controller => "employments", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/employments/1" }.should route_to(:controller => "employments", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/employments/1/edit" }.should route_to(:controller => "employments", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/employments" }.should route_to(:controller => "employments", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/employments/1" }.should route_to(:controller => "employments", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/employments/1" }.should route_to(:controller => "employments", :action => "destroy", :id => "1")
    end

  end
end
