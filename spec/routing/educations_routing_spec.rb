require "spec_helper"

describe EducationsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/educations" }.should route_to(:controller => "educations", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/educations/new" }.should route_to(:controller => "educations", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/educations/1" }.should route_to(:controller => "educations", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/educations/1/edit" }.should route_to(:controller => "educations", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/educations" }.should route_to(:controller => "educations", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/educations/1" }.should route_to(:controller => "educations", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/educations/1" }.should route_to(:controller => "educations", :action => "destroy", :id => "1")
    end

  end
end
