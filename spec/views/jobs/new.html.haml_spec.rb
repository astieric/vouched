require 'spec_helper'

describe "jobs/new.html.haml" do
  before(:each) do
    assign(:job, stub_model(Job,
      :title => "MyString",
      :description => "MyText",
      :city_name => "MyString",
      :state_code => "MyString",
      :country_code => "MyString",
      :url => "MyString",
      :employer => "MyString"
    ).as_new_record)
  end

  it "renders new job form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => jobs_path, :method => "post" do
      assert_select "input#job_title", :name => "job[title]"
      assert_select "textarea#job_description", :name => "job[description]"
      assert_select "input#job_city_name", :name => "job[city_name]"
      assert_select "input#job_state_code", :name => "job[state_code]"
      assert_select "input#job_country_code", :name => "job[country_code]"
      assert_select "input#job_url", :name => "job[url]"
      assert_select "input#job_employer", :name => "job[employer]"
    end
  end
end
