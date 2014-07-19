require 'spec_helper'
describe "contacts/index.html.haml" do
  before(:each) do
    @contacts = [
      stub_model(Contact,
        :identity => stub_model(Identity, :provider => stub_model(Provider, :name => "provider"), :picture => "picture"),
        :name => "name",
        :email => "email"
      ),
      stub_model(Contact,
        :identity => stub_model(Identity, :provider => stub_model(Provider, :name => "provider"), :picture => "picture"),
        :name => "name",
        :email => "email"
      ),
      stub_model(Contact,
        :identity => stub_model(Identity, :provider => stub_model(Provider, :name => "provider"), :picture => "picture"),
        :name => "name",
        :email => "email"
      )
    ]

    @contacts.stub!(:total_pages).and_return(1)
    assign(:contacts, @contacts)
  end

  it "renders a list of contacts" do
    render
    rendered.should have_selector("tr>td", :content => "name".to_s, :count => 3)
    rendered.should have_selector("tr>td", :content => "email".to_s, :count => 3)
    rendered.should have_selector("tr>td>img", :src => "/images/3rdparty/provider_32.png".to_s, :count => 3)
    rendered.should have_selector("tr>td>img", :src => "/images/picture".to_s, :count => 3)

  end
end
