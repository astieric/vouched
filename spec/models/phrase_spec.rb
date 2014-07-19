require 'spec_helper'

describe Phrase do
  before(:each) do
    Factory.create(:phrase)
  end

  should_validate_presence_of   :name
  should_validate_length_of     :name, :maximum => 4000

  should_have_many :translations
  should_have_many :terms,   :through => :translations, :class_name => "Term"


end
