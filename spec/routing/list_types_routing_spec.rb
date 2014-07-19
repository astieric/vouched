require "spec_helper"

describe ListTypesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/list_types" }.should route_to(:controller => "list_types", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/list_types/new" }.should route_to(:controller => "list_types", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/list_types/1" }.should route_to(:controller => "list_types", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/list_types/1/edit" }.should route_to(:controller => "list_types", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/list_types" }.should route_to(:controller => "list_types", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/list_types/1" }.should route_to(:controller => "list_types", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/list_types/1" }.should route_to(:controller => "list_types", :action => "destroy", :id => "1")
    end

  end
end
