require 'spec_helper'

describe "industries/show.html.haml" do
  include Devise::TestHelpers
  before(:each) do
    @industry = assign(:industry, stub_model(Industry,
      :name => "Name"
    ))

    @user = Factory(:user)
    sign_in :user, @user
    @user.has_role!(:admin)

  end

  it "renders attributes in <p>" do
    render
    rendered.should contain("Name".to_s)
  end
end
