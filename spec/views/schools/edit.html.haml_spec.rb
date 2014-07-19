require 'spec_helper'

describe "schools/edit.html.haml" do
  before(:each) do
    @school = assign(:school, stub_model(School,
      :new_record? => false,
      :name => "MyString",
      :website => "MyString",
      :country_id => 1,
      :region_id => 1
    ))
  end

  it "renders the edit school form" do
    render

    rendered.should have_selector("form", :action => school_path(@school), :method => "post") do |form|
      form.should have_selector("input#school_name", :name => "school[name]")
      form.should have_selector("input#school_website", :name => "school[website]")
      form.should have_selector("select#school_country_id", :name => "school[country_id]")
      form.should have_selector("select#school_region_id", :name => "school[region_id]")
    end
  end
end
