require 'spec_helper'

describe "employments/edit.html.haml" do
  before(:each) do
    @employment = assign(:employment, stub_model(Employment,
      :new_record? => false,
      :user_id => 1,
      :title => "MyString",
      :summary => "MyString",
      :start_year => 1,
      :start_month => 1,
      :end_year => 1,
      :end_month => 1,
      :is_current => false,
      :company_name => "MyString",
      :company_id => 1
    ))
  end

  it "renders the edit employment form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => employment_path(@employment), :method => "post" do
      assert_select "input#employment_title", :name => "employment[title]"
      assert_select "input#employment_summary", :name => "employment[summary]"
      assert_select "input#employment_start_year", :name => "employment[start_year]"
      assert_select "input#employment_start_month", :name => "employment[start_month]"
      assert_select "input#employment_end_year", :name => "employment[end_year]"
      assert_select "input#employment_end_month", :name => "employment[end_month]"
      assert_select "input#employment_is_current", :name => "employment[is_current]"
      assert_select "input#employment_company_name", :name => "employment[company_name]"
    end
  end
end
