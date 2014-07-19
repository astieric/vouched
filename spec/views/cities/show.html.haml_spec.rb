require 'spec_helper'

describe "cities/show.html.haml" do
  include Devise::TestHelpers

  before(:each) do
    @city = assign(:city, stub_model(City,
      :name => "Name",
      :country_id => 1,
      :region_id => 1
    ))

    @user = Factory(:user)
    sign_in :user, @user
    @user.has_role!(:admin)

  end

  it "renders attributes in <p>" do
    render
    rendered.should contain("Name".to_s)
    rendered.should contain(1.to_s)
    rendered.should contain(1.to_s)
  end
end
