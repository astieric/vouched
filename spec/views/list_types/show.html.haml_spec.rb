require 'spec_helper'

describe "list_types/show.html.haml" do
  before(:each) do
    @list_type = assign(:list_type, stub_model(ListType,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should contain("Name".to_s)
  end
end
