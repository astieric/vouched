require 'spec_helper'

describe "translations/show.html.haml" do
  before(:each) do
    @translation = assign(:translation, stub_model(Translation,
      :term_id => 1,
      :phrase_id => 1,
      :priority => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should contain(1.to_s)
    rendered.should contain(1.to_s)
    rendered.should contain(1.to_s)
  end
end
