require 'spec_helper'

describe "countries/edit.html.haml" do
  before(:each) do
    @country = assign(:country, stub_model(Country,
      :new_record? => false,
      :code => "MyString",
      :shortname => "MyString",
      :fullname => "MyString",
      :isonumber => 1
    ))
  end

  it "renders the edit country form" do
    render

    rendered.should have_selector("form", :action => country_path(@country), :method => "post") do |form|
      form.should have_selector("input#country_code", :name => "country[code]")
      form.should have_selector("input#country_shortname", :name => "country[shortname]")
      form.should have_selector("input#country_fullname", :name => "country[fullname]")
      form.should have_selector("input#country_isonumber", :name => "country[isonumber]")
    end
  end
end
