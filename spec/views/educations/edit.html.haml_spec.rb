require 'spec_helper'

describe "educations/edit.html.haml" do
  before(:each) do
    @education = assign(:education, stub_model(Education,
      :new_record? => false,
      :school_name => "MyString",
      :degree => "MyString",
      :field_of_study => "MyString",
      :activities => "MyString",
      :start_year => 1,
      :start_month => 1,
      :end_year => 1,
      :end_month => 1
    ))
  end

  it "renders the edit education form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => education_path(@education), :method => "post" do
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
