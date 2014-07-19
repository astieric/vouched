require 'spec_helper'

describe "subindustries/index.html.haml" do
  before(:each) do
    assign(:subindustries, [
      stub_model(Subindustry,
        :name => "Name",
        :industry_id => 1
      ),
      stub_model(Subindustry,
        :name => "Name",
        :industry_id => 1
      )
    ])
    @industry = assign(:industry, stub_model(Industry,
      :new_record? => false,
      :name => "MyString"
    ))
  end

  it "renders a list of subindustries" do
    render
    rendered.should have_selector("tr>td", :content => "Name".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
  end
end
