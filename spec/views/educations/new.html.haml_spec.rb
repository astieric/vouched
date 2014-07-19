require 'spec_helper'

describe "educations/new.html.haml" do
  before(:each) do
    assign(:education, stub_model(Education,
      :user_id => 1,
      :school_name => "MyString",
      :degree => "MyString",
      :field_of_study => "MyString",
      :activities => "MyString",
      :start_year => 1,
      :start_month => 1,
      :end_year => 1,
      :end_month => 1,
      :school_id => 1
    ).as_new_record)
  end

  it "renders new education form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => educations_path, :method => "post" do
      assert_select "input#education_school_name", :name => "education[school_name]"
      assert_select "input#education_degree", :name => "education[degree]"
      assert_select "input#education_field_of_study", :name => "education[field_of_study]"
      assert_select "input#education_activities", :name => "education[activities]"
      assert_select "input#education_start_year", :name => "education[start_year]"
      assert_select "input#education_start_month", :name => "education[start_month]"
      assert_select "input#education_end_year", :name => "education[end_year]"
      assert_select "input#education_end_month", :name => "education[end_month]"
    end
  end
end
