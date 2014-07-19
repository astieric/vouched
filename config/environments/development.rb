GetvouchedCom::Application.configure do
  # Settings specified here will take precedence over those in config/environment.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  config.active_support.deprecation = :log

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = false

  # Don't send e-mails!
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = false

  # Required for Devise
  config.action_mailer.default_url_options = { :host => 'getvouched.com' }

  config.action_mailer.smtp_settings = 
    {
      :address => "smtp.sendgrid.net",
      :port => '25',
      :domain => "getvouched.com",
      :authentication => :plain,
      :user_name => "astier.eric@gmail.com",
      :password => "gsdfa2343ZDfsdfdf"
    }


  config.after_initialize do
    Bullet.enable = true
    Bullet.bullet_logger = true
    Bullet.console = true
    Bullet.rails_logger = true
    Bullet.disable_browser_cache = true
end

end

Sunspot.config.solr.url = 'http://localhost:8982/solr'

TWITTER_ID       = 'We0LCUEQcEkbKgI8ndp2yg'
TWITTER_SECRET   = 'TkPQ2RpqvGkJ2B7MD0GB1k8xwqWq5Yll89NnoXjXKA'
FACEBOOK_ID      = '114372748598223'
FACEBOOK_SECRET  = 'd73b23b13df91a368c88ce34c4aeb81c'
GITHUB_ID        = '05ff24be8c780287a210'
GITHUB_SECRET    = 'fadd2231f9c60f36e74f72a291e1ac20964fc587'
LINKED_IN_ID     = 'd-nIOVnS_ngahsfM2_DrKxh2Pp3iIvMymJYAXlHg165rNTgNMVXuLE6jccSHxDVA'
LINKED_IN_SECRET = 'ecugeCTONAFf8WaVgf_iRBdsK0qmk7rTNf1oLSZnOHuUzE796iYpCRfqIrQ-ewnY'

