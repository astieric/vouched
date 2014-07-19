require 'spec_helper'

describe "subindustries/show.html.haml" do
  include Devise::TestHelpers

  before(:each) do
    @subindustry = assign(:subindustry, stub_model(Subindustry,
      :name => "Name",
      :industry_id => 1
    ))
    @industry = assign(:industry, stub_model(Industry,
      :new_record? => false,
      :name => "MyString"
    ))

    @user = Factory(:user)
    sign_in :user, @user
    @user.has_role!(:admin)

  end

  it "renders attributes in <p>" do
    render
    rendered.should contain("Name".to_s)
    rendered.should contain(1.to_s)
  end
end
