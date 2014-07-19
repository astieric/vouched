require 'spec_helper'

describe "regions/new.html.haml" do
  before(:each) do
    @region = assign(:region, Region.new)
  end

  it "renders new region form" do
    render

    rendered.should have_selector("form", :action => regions_path, :method => "post") do |form|
      form.should have_selector("input#region_name", :name => "region[name]")
      form.should have_selector("input#region_code", :name => "region[code]")
      form.should have_selector("select#region_country_id", :name => "region[country_id]")
    end
  end
end
