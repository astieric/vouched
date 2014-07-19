require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter,   TWITTER_ID,   TWITTER_SECRET
  provider :facebook,  FACEBOOK_ID,  FACEBOOK_SECRET, { :scope => 'email,offline_access,user_work_history,friends_work_history,user_education_history,friends_education_history,user_hometown,friends_hometown'}
  provider :github,    GITHUB_ID,    GITHUB_SECRET
  provider :linked_in, LINKED_IN_ID, LINKED_IN_SECRET
  provider :open_id, OpenID::Store::Filesystem.new('/tmp')
end
