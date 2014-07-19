require 'spec_helper'

describe "phrases/show.html.haml" do
  before(:each) do
    @phrase = assign(:phrase, stub_model(Phrase,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should contain("Name".to_s)
  end
end
