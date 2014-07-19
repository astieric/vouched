require 'spec_helper'

describe "translations/new.html.haml" do
  before(:each) do
    @translation = assign(:translation, Translation.new)
  end

  it "renders new translation form" do
    render

    rendered.should have_selector("form", :action => translations_path, :method => "post") do |form|
      form.should have_selector("select#translation_term_id", :name => "translation[term_id]")
      form.should have_selector("select#translation_phrase_id", :name => "translation[phrase_id]")
      form.should have_selector("input#translation_priority", :name => "translation[priority]")
    end
  end
end
