require 'spec_helper'

describe "countries/index.html.haml" do
  before(:each) do
    assign(:countries, [
      stub_model(Country,
        :code => "Code",
        :shortname => "Shortname",
        :fullname => "Fullname",
        :isonumber => 1
      ),
      stub_model(Country,
        :code => "Code",
        :shortname => "Shortname",
        :fullname => "Fullname",
        :isonumber => 1
      )
    ])
  end

  it "renders a list of countries" do
    render
    rendered.should have_selector("tr>td", :content => "Code".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Shortname".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Fullname".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
  end
end
