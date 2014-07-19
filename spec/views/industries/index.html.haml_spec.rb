require 'spec_helper'

describe "industries/index.html.haml" do
  before(:each) do
    assign(:industries, [
      stub_model(Industry,
        :name => "Name"
      ),
      stub_model(Industry,
        :name => "Name"
      )
    ])
  end

  it "renders a list of industries" do
    render
    rendered.should have_selector("tr>td", :content => "Name".to_s, :count => 2)
  end
end
