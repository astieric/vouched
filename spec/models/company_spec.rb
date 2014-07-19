require 'spec_helper'

describe Company do
  before(:each) do
    Factory.create(:company)
  end

  should_validate_presence_of :name
  should_validate_length_of :name, :maximum => 200

  should_validate_length_of :website,      :maximum => 200
  should_validate_length_of :phone,        :minimum => 3, :maximum => 50
  should_validate_length_of :address,      :maximum => 200
  should_validate_length_of :city_name,    :maximum => 100
  should_validate_length_of :state,        :maximum => 100
  should_validate_length_of :zip,          :maximum => 50
  should_validate_length_of :country_name, :maximum => 100

  should_belong_to :industry
  should_belong_to :subindustry
  should_belong_to :country
  should_belong_to :region
  should_belong_to :city

  it_should_behave_like "it has_search_type"
  it "should be searchable" do
    Company.should be_searchable
  end
  it_should_behave_like "it has_coordinates"

end
