require 'spec_helper'
require 'rubygems'
require 'ruby-debug'

describe User do
  before(:each) do
    Factory.create(:user)
  end

  should_validate_presence_of :username
  should_validate_presence_of :email
  should_validate_presence_of :password

  should_validate_uniqueness_of :username
  should_validate_uniqueness_of :email

  should_have_many :archetypes
  should_have_many :identities
  should_have_many :jobs
  should_have_many :lists

  should_have_one :google
  should_have_one :yahoo

  it_should_behave_like "it has_search_type"
  it "should be searchable" do
    User.should be_searchable
  end

  it_should_behave_like "it has_uuid"
  it_should_behave_like "it has_vouches"
  it_should_behave_like "it has_terms"
end