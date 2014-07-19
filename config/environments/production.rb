GetvouchedCom::Application.configure do
  # Settings specified here will take precedence over those in config/environment.rb

  # The production environment is meant for finished, "live" apps.
  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Specifies the header that your server uses for sending files
  config.action_dispatch.x_sendfile_header = "X-Sendfile"

  # For nginx:
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect'

  # If you have no front-end server that supports something like X-Sendfile,
  # just comment this out and Rails will serve the files

  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Use a different logger for distributed setups
  # config.logger = SyslogLogger.new

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store

  # Disable Rails's static asset server
  # In production, Apache or nginx will already do this
  config.serve_static_assets = false

  # Enable serving of images, stylesheets, and javascripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  # Enable threaded mode
  # config.threadsafe!
end

Sunspot.config.solr.url = 'http://localhost:8982/solr'

TWITTER_ID       = 'We0LCUEQcEkbKgI5ndp2yg'
TWITTER_SECRET   = 'TkPQ2RpqvGkJ4B7MD0GB1k8xwqWq5Yll89NnoXjXKA'
FACEBOOK_ID      = '114372748598923'
FACEBOOK_SECRET  = 'd73b23b13df95a368c88ce34c4aeb81c'
GITHUB_ID        = 'e096058fe0358fcba21b'
GITHUB_SECRET    = '7378792ce9cd3a32ba80a4c73e923fc14148d65d'
LINKED_IN_ID     = 'd-nIOVnS_ngahsfM1_DrKxh2Pp3iIvMymJYAXlHg165rNTgNMVXuLE6jccSHxDVA'
LINKED_IN_SECRET = 'ecugeCTONAFf8WxVgf_iRBdsK0qmk7rTNf1oLSZnOHuUzE796iYpCRfqIrQ-ewnY'