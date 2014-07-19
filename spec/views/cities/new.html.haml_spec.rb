require 'spec_helper'

describe "cities/new.html.haml" do
  before(:each) do
    @city = assign(:city, City.new)
  end

  it "renders new city form" do
    render

    rendered.should have_selector("form", :action => cities_path, :method => "post") do |form|
      form.should have_selector("input#city_name", :name => "city[name]")
      form.should have_selector("select#city_country_id", :name => "city[country_id]")
      form.should have_selector("select#city_region_id", :name => "city[region_id]")
    end
  end
end
