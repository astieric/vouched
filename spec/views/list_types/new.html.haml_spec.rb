require 'spec_helper'

describe "list_types/new.html.haml" do
  before(:each) do
    @list_type = assign(:list_type, ListType.new)
  end

  it "renders new list_type form" do
    render

    rendered.should have_selector("form", :action => list_types_path, :method => "post") do |form|
      form.should have_selector("input#list_type_name", :name => "list_type[name]")
    end
  end
end
