require 'spec_helper'

describe "list_types/edit.html.haml" do
  before(:each) do
    @list_type = assign(:list_type, stub_model(ListType,
      :new_record? => false,
      :name => "MyString"
    ))
  end

  it "renders the edit list_type form" do
    render

    rendered.should have_selector("form", :action => list_type_path(@list_type), :method => "post") do |form|
      form.should have_selector("input#list_type_name", :name => "list_type[name]")
    end
  end
end
