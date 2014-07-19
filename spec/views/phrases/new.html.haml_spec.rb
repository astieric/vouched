require 'spec_helper'

describe "phrases/new.html.haml" do
  before(:each) do
    @phrase = assign(:phrase, Phrase.new)
  end

  it "renders new phrase form" do
    render

    rendered.should have_selector("form", :action => phrases_path, :method => "post") do |form|
      form.should have_selector("input#phrase_name", :name => "phrase[name]")
    end
  end
end
