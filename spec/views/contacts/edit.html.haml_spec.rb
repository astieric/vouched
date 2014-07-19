require 'spec_helper'

describe "contacts/edit.html.haml" do
  before(:each) do
    @contact = assign(:contact, stub_model(Contact,
      :new_record? => false,
      :user_id => "MyString",
      :identity_id => "MyString",
      :name => "MyString",
      :email => "MyString"
    ))
  end

  it "renders the edit contact form" do
    render

    rendered.should have_selector("form", :action => contact_path(@contact), :method => "post") do |form|
      form.should have_selector("input#contact_name", :name => "contact[name]")
      form.should have_selector("input#contact_email", :name => "contact[email]")
    end
  end
end
