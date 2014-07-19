GetvouchedCom::Application.configure do
  # Settings specified here will take precedence over those in config/environment.rb

  # The test environment is used exclusively to run your application's
  # test suite.  You never need to work with it otherwise.  Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs.  Don't rely on the data there!
  config.cache_classes = true

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true
  config.active_support.deprecation = :log

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment
  config.action_controller.allow_forgery_protection    = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  config.action_mailer.default_url_options = { :host => 'test.getvouched.com' }

  config.action_mailer.smtp_settings = 
    {
      :address => "test.net",
      :port => '25',
      :domain => "test.getvouched.com",
      :authentication => :plain,
      :user_name => "test@hotmail.com",
      :password => "test"
    }

  # Depracation Warnings  
  config.active_support.deprecation = :stderr

end

Sunspot.config.solr.url = 'http://localhost:8982/solr'

Sunspot.config.solr.url = 'http://localhost:8982/solr'

TWITTER_ID       = 'We0LCUEQcEkbKgI5ndp2yg'
TWITTER_SECRET   = 'TkPQ2RpqvGkJ4B7MD0GB1k8xwqWq5Yll89NnoXjXKA'
FACEBOOK_ID      = '114372748598923'
FACEBOOK_SECRET  = 'd73b23b13df95a368c88ce34c4aeb81c'
GITHUB_ID        = '05ff24be8c780887a210'
GITHUB_SECRET    = 'fadd2231f9c60f56e74f72a291e1ac20964fc587'
LINKED_IN_ID     = 'd-nIOVnS_ngahsfM1_DrKxh2Pp3iIvMymJYAXlHg165rNTgNMVXuLE6jccSHxDVA'
LINKED_IN_SECRET = 'ecugeCTONAFf8WxVgf_iRBdsK0qmk7rTNf1oLSZnOHuUzE796iYpCRfqIrQ-ewnY'