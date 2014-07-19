require 'spec_helper'

describe "countries/show.html.haml" do
  include Devise::TestHelpers

  before(:each) do
    @country = assign(:country, stub_model(Country,
      :code => "Code",
      :shortname => "Shortname",
      :fullname => "Fullname",
      :isonumber => 1
    ))

    @user = Factory(:user)
    sign_in :user, @user
    @user.has_role!(:admin)

  end

  it "renders attributes in <p>" do
    render
    rendered.should contain("Code".to_s)
    rendered.should contain("Shortname".to_s)
    rendered.should contain("Fullname".to_s)
    rendered.should contain(1.to_s)
  end
end
