require 'spec_helper'

describe "contacts/show.html.haml" do
  before(:each) do
    @contact = assign(:contact, stub_model(Contact,
      :user_id => "User",
      :identity_id => "Identity",
      :name => "Name",
      :email => "Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should contain("Name".to_s)
    rendered.should contain("Email".to_s)
  end
end
