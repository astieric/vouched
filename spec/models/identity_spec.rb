require 'spec_helper'

describe Identity do
  it_should_behave_like "it has_search_type"

  it "should be searchable" do
    Identity.should be_searchable
  end

  should_belong_to :provider
  should_belong_to :user
  should_have_many :contacts
  
  it_should_behave_like "it has_uuid"
  it_should_behave_like "it has_vouches"
  it_should_behave_like "it has_terms"

  describe "apply_omniauth" do
    include OmniauthResults
    let(:empty_identity) { Factory.create(:empty_identity) }

    it "should apply omniauth info for facebook" do
      empty_identity.apply_omniauth get_results_for :facebook
      empty_identity.token.should eql "FacebookToken"
      empty_identity.secret.should eql "FacebookSecret"

      empty_identity.name.should eql "FacebookName"
      empty_identity.nickname.should eql "FacebookNickname"
      empty_identity.url.should eql "http://www.facebook.com/facebook.name"
      empty_identity.email.should eql "facebook@email.com"
    end

    it "should apply omniauth info for twitter" do
      empty_identity.apply_omniauth get_results_for :twitter
      empty_identity.token.should eql "TwitterToken"
      empty_identity.secret.should eql "TwitterSecret"

      empty_identity.name.should eql "TwitterName"
      empty_identity.nickname.should eql "TwitterNickname"
      empty_identity.url.should eql "http://twitter.com/TwitterNickname"
    end

    it "should apply omniauth info for LinkedIn" do
      empty_identity.apply_omniauth get_results_for :linked_in
      empty_identity.token.should eql "LinkedInToken"
      empty_identity.secret.should eql "LinkedInSecret"

      empty_identity.name.should eql "LinkedInName"
      empty_identity.nickname.should eql "linkedinfirstname.linkedinlastname"
    end

    it "should apply omniauth info for Github" do
      empty_identity.apply_omniauth get_results_for :github
      empty_identity.token.should eql "GithubToken"
      empty_identity.secret.should eql "GithubSecret"

      empty_identity.name.should eql "GithubName"
      empty_identity.nickname.should eql "GithubNickName"
      empty_identity.url.should eql "http://github.comGithubNickName"
    end
  end
end
