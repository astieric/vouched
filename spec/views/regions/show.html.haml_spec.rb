require 'spec_helper'

describe "regions/show.html.haml" do
  include Devise::TestHelpers

  before(:each) do
    @region = assign(:region, stub_model(Region,
      :name => "Name",
      :code => "Code",
      :country_id => 1
    ))

    @user = Factory(:user)
    sign_in :user, @user
    @user.has_role!(:admin)

  end

  it "renders attributes in <p>" do
    render
    rendered.should contain("Name".to_s)
    rendered.should contain("Code".to_s)
    rendered.should contain(1.to_s)
  end
end
