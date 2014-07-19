require 'spec_helper'

describe "subindustries/edit.html.haml" do
  before(:each) do
    @subindustry = assign(:subindustry, stub_model(Subindustry,
      :new_record? => false,
      :name => "MyString",
      :industry_id => 1
    ))
    @industry = assign(:industry, stub_model(Industry,
      :new_record? => false,
      :name => "MyString"
    ))
  end

  it "renders the edit subindustry form" do
    render

    rendered.should have_selector("form", :action => industry_subindustry_path(@industry, @subindustry), :method => "post") do |form|
      form.should have_selector("input#subindustry_name", :name => "subindustry[name]")
      form.should have_selector("select#subindustry_industry_id", :name => "subindustry[industry_id]")
    end
  end
end
