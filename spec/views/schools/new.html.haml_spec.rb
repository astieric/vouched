require 'spec_helper'

describe "schools/new.html.haml" do
  before(:each) do
    @school = assign(:school, School.new)
  end

  it "renders new school form" do
    render

    rendered.should have_selector("form", :action => schools_path, :method => "post") do |form|
      form.should have_selector("input#school_name", :name => "school[name]")
      form.should have_selector("input#school_website", :name => "school[website]")
      form.should have_selector("select#school_country_id", :name => "school[country_id]")
      form.should have_selector("select#school_region_id", :name => "school[region_id]")
    end
  end
end
