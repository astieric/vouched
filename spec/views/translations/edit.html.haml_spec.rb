require 'spec_helper'

describe "translations/edit.html.haml" do
  before(:each) do
    @translation = assign(:translation, stub_model(Translation,
      :new_record? => false,
      :term_id => 1,
      :phrase_id => 1,
      :priority => 1
    ))
  end

  it "renders the edit translation form" do
    render

    rendered.should have_selector("form", :action => translation_path(@translation), :method => "post") do |form|
      form.should have_selector("select#translation_term_id", :name => "translation[term_id]")
      form.should have_selector("select#translation_phrase_id", :name => "translation[phrase_id]")
      form.should have_selector("input#translation_priority", :name => "translation[priority]")
    end
  end
end
