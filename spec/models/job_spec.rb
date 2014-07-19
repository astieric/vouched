require 'spec_helper'

describe Job do
  before(:each) do
    Factory.create(:job)
  end


  it_should_behave_like "it has_uuid"
  it_should_behave_like "it has_terms"

  it_should_behave_like "it has_search_type"
  it "should be searchable" do
    Job.should be_searchable
  end
  it_should_behave_like "it has_coordinates"

  should_validate_presence_of :title
  should_validate_presence_of :description
  should_validate_presence_of :city_name
  should_validate_presence_of :state_code
  should_validate_presence_of :country_code
  should_validate_presence_of :employer
  should_validate_presence_of :user_id

  should_validate_length_of :title,         :minimum => 1,  :maximum => 255
  should_validate_length_of :city_name,     :minimum => 1,  :maximum => 255
  should_validate_length_of :state_code,    :minimum => 1,  :maximum => 255
  should_validate_length_of :country_code,  :minimum => 1,  :maximum => 255
  should_validate_length_of :employer,      :minimum => 1,  :maximum => 255
  should_validate_length_of :user_id,       :minimum => 36, :maximum => 36

  should_belong_to :user
  should_belong_to :city
  should_belong_to :region
  should_belong_to :country
  should_belong_to :company
end
