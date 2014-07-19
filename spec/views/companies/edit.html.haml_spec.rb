require 'spec_helper'

describe "companies/edit.html.haml" do
  before(:each) do
    @company = assign(:company, stub_model(Company,
      :new_record? => false,
      :jigsawid => 1,
      :name => "MyString",
      :website => "MyString",
      :phone => "MyString",
      :address => "MyString",
      :city_name => "MyString",
      :state => "MyString",
      :zip => "MyString",
      :country_name => "MyString",
      :industry_id => 1,
      :subindustry_id => 1,
      :city_id => 1,
      :region_id => 1,
      :country_id => 1
    ))
  end

  it "renders the edit company form" do
    render

    rendered.should have_selector("form", :action => company_path(@company), :method => "post") do |form|
      form.should have_selector("input#company_jigsawid", :name => "company[jigsawid]")
      form.should have_selector("input#company_name", :name => "company[name]")
      form.should have_selector("input#company_website", :name => "company[website]")
      form.should have_selector("input#company_phone", :name => "company[phone]")
      form.should have_selector("input#company_address", :name => "company[address]")
      form.should have_selector("input#company_city_name", :name => "company[city_name]")
      form.should have_selector("input#company_state", :name => "company[state]")
      form.should have_selector("input#company_zip", :name => "company[zip]")
      form.should have_selector("input#company_country_name", :name => "company[country_name]")
      form.should have_selector("select#company_industry_id", :name => "company[industry_id]")
      form.should have_selector("select#company_subindustry_id", :name => "company[subindustry_id]")
      form.should have_selector("select#company_city_id", :name => "company[city_id]")
      form.should have_selector("select#company_region_id", :name => "company[region_id]")
      form.should have_selector("select#company_country_id", :name => "company[country_id]")
    end
  end
end
