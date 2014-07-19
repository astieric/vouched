require 'spec_helper'

describe ArchetypesController do
  it "should respond to autocomplete" do
    5.times { Factory.create :archetype_name_starts_with_ru }  
    xhr :post, "autocomplete", :name => 'Ru'
    response.should be_success
    body = JSON.parse response.body
    body.each { |term| 
      (term["archetype"]["name"].downcase =~ /^ru/).should eql 0
    }
  end
end
