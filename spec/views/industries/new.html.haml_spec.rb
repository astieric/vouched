require 'spec_helper'

describe "industries/new.html.haml" do
  before(:each) do
    @industry = assign(:industry, Industry.new)
  end

  it "renders new industry form" do
    render

    rendered.should have_selector("form", :action => industries_path, :method => "post") do |form|
      form.should have_selector("input#industry_name", :name => "industry[name]")
    end
  end
end
