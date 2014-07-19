require 'spec_helper'

describe "translations/index.html.haml" do
  before(:each) do
    assign(:translations, [
      stub_model(Translation,
        :term_id => 1,
        :phrase_id => 2,
        :priority => 3
      ),
      stub_model(Translation,
        :term_id => 1,
        :phrase_id => 3,
        :priority => 2
      )
    ])
  end

  it "renders a list of translations" do
    render
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 2.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 3.to_s, :count => 2)
  end
end
