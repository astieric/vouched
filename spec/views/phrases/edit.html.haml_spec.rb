require 'spec_helper'

describe "phrases/edit.html.haml" do
  before(:each) do
    @phrase = assign(:phrase, stub_model(Phrase,
      :new_record? => false,
      :name => "MyString"
    ))
  end

  it "renders the edit phrase form" do
    render

    rendered.should have_selector("form", :action => phrase_path(@phrase), :method => "post") do |form|
      form.should have_selector("input#phrase_name", :name => "phrase[name]")
    end
  end
end
