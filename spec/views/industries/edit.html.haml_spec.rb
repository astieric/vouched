require 'spec_helper'

describe "industries/edit.html.haml" do
  before(:each) do
    @industry = assign(:industry, stub_model(Industry,
      :new_record? => false,
      :name => "MyString"
    ))
  end

  it "renders the edit industry form" do
    render

    rendered.should have_selector("form", :action => industry_path(@industry), :method => "post") do |form|
      form.should have_selector("input#industry_name", :name => "industry[name]")
    end
  end
end
