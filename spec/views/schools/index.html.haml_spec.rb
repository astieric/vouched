require 'spec_helper'

describe "schools/index.html.haml" do
  before(:each) do
    assign(:schools, [
      stub_model(School,
        :name => "Name",
        :website => "Website",
        :country_id => 1,
        :region_id => 1
      ),
      stub_model(School,
        :name => "Name",
        :website => "Website",
        :country_id => 2,
        :region_id => 2
      )
    ])
  end

  it "renders a list of schools" do
    render
    rendered.should have_selector("tr>td", :content => "Name".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Website".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 2.to_s, :count => 2)
  end
end
