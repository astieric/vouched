require 'spec_helper'

describe "employments/index.html.haml" do
  before(:each) do
    assign(:facebook_employments, [])
    assign(:linked_in_employments, [])
    assign(:employments, [
      stub_model(Employment,
        :title => "Title",
        :summary => "Summary",
        :start_year => 2010,
        :start_month => 3,
        :end_year => 2011,
        :end_month => 12,
        :is_current => false,
        :company_name => "Company",
        :provider_id => 0
      ),
      stub_model(Employment,
        :title => "Title",
        :summary => "Summary",
        :start_year => 2010,
        :start_month => 3,
        :end_year => 2011,
        :end_month => 12,
        :is_current => false,
        :company_name => "Company",
        :provider_id => 0
      )
    ])
  end

  it "renders a list of employments" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Summary".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 2010.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 3.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 2011.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 12.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Company".to_s, :count => 2
  end
end
