require 'spec_helper'

describe "phrases/index.html.haml" do
  before(:each) do
    assign(:phrases, [
      stub_model(Phrase,
        :name => "Name"
      ),
      stub_model(Phrase,
        :name => "Name"
      )
    ])
  end

  it "renders a list of phrases" do
    render
    rendered.should have_selector("tr>td", :content => "Name".to_s, :count => 2)
  end
end
