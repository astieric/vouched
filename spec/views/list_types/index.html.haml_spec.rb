require 'spec_helper'

describe "list_types/index.html.haml" do
  before(:each) do
    assign(:list_types, [
      stub_model(ListType,
        :name => "Name"
      ),
      stub_model(ListType,
        :name => "Name"
      )
    ])
  end

  it "renders a list of list_types" do
    render
    rendered.should have_selector("tr>td", :content => "Name".to_s, :count => 2)
  end
end
