require 'spec_helper'

describe "educations/index.html.haml" do
  before(:each) do
    assign(:facebook_educations, [])
    assign(:linked_in_educations, [])
    assign(:educations, [
      stub_model(Education,
        :school_name => "School Name",
        :degree => "Degree",
        :field_of_study => "Field Of Study",
        :activities => "Activities",
        :start_year => 2010,
        :start_month => 3,
        :end_year => 2011,
        :end_month => 12
      ),
      stub_model(Education,
        :school_name => "School Name",
        :degree => "Degree",
        :field_of_study => "Field Of Study",
        :activities => "Activities",
        :start_year => 2010,
        :start_month => 3,
        :end_year => 2011,
        :end_month => 12
      )
    ])
  end

  it "renders a list of educations" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "School Name".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Degree".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Field Of Study".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Activities".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 2010.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 3.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 2011.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 12.to_s, :count => 2
  end
end
