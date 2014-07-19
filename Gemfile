source 'http://rubygems.org'

# Rails
gem 'rails', '3.0.5'

# Jruby Specific
if defined?(JRUBY_VERSION) 
   gem 'jruby-openssl'
   gem 'libxml-jruby'
else
   gem 'libxml-ruby'
end

gem 'json'

# just in case we decide to switch to Postgre:
if defined?(JRUBY_VERSION)
  gem 'activerecord-jdbc-adapter'
  gem 'activerecord-jdbcpostgresql-adapter'
  gem 'jdbc-postgres'
else
  gem 'pg'
end

# Authentication and Authorization
gem 'devise', '1.1.2' #update to 1.2 soon.
gem 'acl9'
gem 'omniauth'

# 3rd Party APIs
gem 'fbgraph'
gem 'twitter', :git => 'http://github.com/jnunemaker/twitter.git'
gem 'linkedin'
gem 'httparty'

# Bundle the extra gems:
gem 'crack'

gem 'inherited_resources', '1.1.2'
gem 'nokogiri'
gem 'paper_trail' #, :git => 'http://github.com/lailsonbm/paper_trail.git'

# New Gems for Integration with beta
gem 'oauth', :git => 'http://github.com/pelle/oauth.git'
gem 'oauth-plugin', :git => 'http://github.com/pelle/oauth-plugin.git' , :branch => 'rails3'
gem 'portablecontacts'
gem 'will_paginate', '~> 3.0.pre2'
gem 'state_machine', '0.9.4'
gem 'has_messages', '0.4.1'
gem 'dynamic_form', '1.0.0', :git => 'http://github.com/rails/dynamic_form.git'
gem 'formtastic', '1.1.0'
gem 'rails3-generators'
# gem 'exception_notification', :git => 'http://github.com/rails/exception_notification.git'
gem 'hpricot'

# Haml and Sass
gem 'haml', '3.0.18'
gem 'haml-rails'
gem 'compass', '0.10.4'
gem 'compass-960-plugin', '0.9.13'

gem 'gravtastic', '>= 3.1.0'

# New Relic Application Monitoring
#gem 'newrelic_rpm', :git=> 'http://github.com/newrelic/rpm.git' # This is breaking Postgre with "undefined method `split' for :skip_logging:Symbol"
#gem 'newrelic_rpm', :git=> 'https://github.com/jaggederest/rpm.git' # Same as above... send in patch if we care.

# Sunspot
gem 'sunspot_rails', :git => 'http://github.com/nbraem/sunspot.git'
gem 'pr_geohash'

gem 'rcov'
gem 'rest-client' , :require => 'rest_client'

# Neo4j 
#gem 'neo4jr-simple'
#gem 'neo4jr-social'
gem 'sinatra'

# UUID
gem 'uuidtools', :require => 'uuidtools'

# Active Record modifiers
gem 'activerecord-import'
gem 'acts_as_list', :git => 'http://github.com/augustl/acts_as_list.git'

# Using glassfish as the web server
# gem 'unicorn'

group :development do
  gem 'ruby-debug19'
  gem 'rspec-rails', '>= 2.0.1'
  gem 'rails_code_qa'
  gem 'silent-postgres'  #keep development logs small
  gem 'bullet' #notify of N+1 queries, missing counter cache and unused eager loading
end

# Testing Gems
group :test do
  gem 'database_cleaner', '>=0.6.0'
  gem 'cucumber-rails'
  gem 'capybara'
  gem 'term-ansicolor'
  gem 'cucumber'
  gem 'spork'
  gem 'launchy'    # So you can do Then show me the page
  gem 'factory_girl'
  gem 'forgery'
  gem 'webrat'
  gem 'rspec-rails', '>= 2.0.1'
  gem 'remarkable', '>=4.0.0.alpha4'
  gem 'remarkable_activemodel', '>=4.0.0.alpha4'
  gem 'remarkable_activerecord', '>=4.0.0.alpha4'
end

gem 'friendly_id'