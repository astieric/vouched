require 'spec_helper'

describe "companies/show.html.haml" do
  include Devise::TestHelpers

  before(:each) do
    @company = assign(:company, stub_model(Company,
      :jigsawid => 1,
      :name => "Name",
      :website => "Website",
      :phone => "Phone",
      :address => "Address",
      :city_name => "City Name",
      :state => "State",
      :zip => "Zip",
      :country_name => "Country Name",
      :industry_id => 1,
      :subindustry_id => 1,
      :city_id => 1,
      :region_id => 1,
      :country_id => 1
    ))

    @user = Factory(:user)
    sign_in :user, @user
    @user.has_role!(:admin)

  end

  it "renders attributes in <p>" do
    render
    rendered.should contain(1.to_s)
    rendered.should contain("Name".to_s)
    rendered.should contain("Website".to_s)
    rendered.should contain("Phone".to_s)
    rendered.should contain("Address".to_s)
    rendered.should contain("City Name".to_s)
    rendered.should contain("State".to_s)
    rendered.should contain("Zip".to_s)
    rendered.should contain("Country Name".to_s)
    rendered.should contain(1.to_s)
    rendered.should contain(1.to_s)
    rendered.should contain(1.to_s)
    rendered.should contain(1.to_s)
    rendered.should contain(1.to_s)
  end
end
