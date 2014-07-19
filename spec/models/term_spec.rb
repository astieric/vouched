require 'spec_helper'
require 'rubygems'
require 'ruby-debug'

describe Term do
  before(:each) do
    Factory.create(:term)
  end

  should_validate_presence_of :name
  should_validate_length_of :name, :minimum => 1, :maximum => 255

  should_have_many :resource_terms
  should_have_many :translations
  should_have_many :phrases, :through => :translations
  should_have_many :vouches

  it "should find term with name like" do 
    Term.delete_all
    5.times { Factory.create :term_starts_with_ru }
    ru_terms = Term.with_name_like "ru"
    ru_terms.length.should eql 5
    ru_terms.each { |term|
      (term.name.downcase =~ /^ru/).should eql 0
    }
  end
end
