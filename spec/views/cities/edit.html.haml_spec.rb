require 'spec_helper'

describe "cities/edit.html.haml" do
  before(:each) do
    @city = assign(:city, stub_model(City,
      :new_record? => false,
      :name => "MyString",
      :country_id => 1,
      :region_id => 1
    ))
  end

  it "renders the edit city form" do
    render

    rendered.should have_selector("form", :action => city_path(@city), :method => "post") do |form|
      form.should have_selector("input#city_name", :name => "city[name]")
      form.should have_selector("select#city_country_id", :name => "city[country_id]")
      form.should have_selector("select#city_region_id", :name => "city[region_id]")
    end
  end
end
