require 'spec_helper'

describe "regions/edit.html.haml" do
  before(:each) do
    @region = assign(:region, stub_model(Region,
      :new_record? => false,
      :name => "MyString",
      :code => "MyString",
      :country_id => 1
    ))
  end

  it "renders the edit region form" do
    render

    rendered.should have_selector("form", :action => region_path(@region), :method => "post") do |form|
      form.should have_selector("input#region_name", :name => "region[name]")
      form.should have_selector("input#region_code", :name => "region[code]")
      form.should have_selector("select#region_country_id", :name => "region[country_id]")
    end
  end
end
