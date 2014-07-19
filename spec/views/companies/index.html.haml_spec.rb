require 'spec_helper'

describe "companies/index.html.haml" do
  before(:each) do
    assign(:companies, [
      stub_model(Company,
        :jigsawid => 1,
        :name => "Name",
        :website => "Website",
        :phone => "Phone",
        :address => "Address",
        :city_name => "City",
        :state => "State",
        :zip => "Zip",
        :country_name => "Country",
        :industry_id => 2,
        :subindustry_id => 3,
        :city_id => 4,
        :region_id => 5,
        :country_id => 6
      ),
      stub_model(Company,
        :jigsawid => 1,
        :name => "Name",
        :website => "Website",
        :phone => "Phone",
        :address => "Address",
        :city_name => "City",
        :state => "State",
        :zip => "Zip",
        :country_name => "Country",
        :industry_id => 2,
        :subindustry_id => 3,
        :city_id => 4,
        :region_id => 5,
        :country_id => 6
      )
    ])
  end

  it "renders a list of companies" do
    render
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Name".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Website".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Phone".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Address".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "City".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "State".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Zip".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Country".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 2.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 3.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 4.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 5.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 6.to_s, :count => 2)
  end
end
