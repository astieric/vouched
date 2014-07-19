require 'spec_helper'

describe "regions/index.html.haml" do
  before(:each) do
    assign(:regions, [
      stub_model(Region,
        :name => "Name",
        :code => "Code",
        :country => stub_model(Country,
          :code => "Code",
          :shortname => "Shortname",
          :fullname => "Fullname",
          :isonumber => 1
        )
      ),
      stub_model(Region,
        :name => "Name",
        :code => "Code",
        :country => stub_model(Country,
          :code => "Code",
          :shortname => "Shortname",
          :fullname => "Fullname",
          :isonumber => 1
        )
      )
    ])
  end

  it "renders a list of regions" do
    render
    rendered.should have_selector("tr>td", :content => "Name".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Code".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Shortname".to_s, :count => 2)
  end
end
