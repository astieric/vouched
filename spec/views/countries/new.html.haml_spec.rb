require 'spec_helper'

describe "countries/new.html.haml" do
  before(:each) do
    @country = assign(:country, Country.new)
  end

  it "renders new country form" do
    render

    rendered.should have_selector("form", :action => countries_path, :method => "post") do |form|
      form.should have_selector("input#country_code", :name => "country[code]")
      form.should have_selector("input#country_shortname", :name => "country[shortname]")
      form.should have_selector("input#country_fullname", :name => "country[fullname]")
      form.should have_selector("input#country_isonumber", :name => "country[isonumber]")
    end
  end
end
