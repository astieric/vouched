require 'spec_helper'

describe "subindustries/new.html.haml" do
  before(:each) do
    @subindustry = assign(:subindustry, Subindustry.new)
    @industry = assign(:industry, stub_model(Industry,
      :new_record? => false,
      :name => "MyString"
    ))
  end

  it "renders new subindustry form" do
    render
    puts rendered
    rendered.should have_selector("form", :action => industry_subindustries_path(@industry), :method => "post") do |form|
      form.should have_selector("input#subindustry_name", :name => "subindustry[name]")
      form.should have_selector("select#subindustry_industry_id", :name => "subindustry[industry_id]")
    end
  end
end
