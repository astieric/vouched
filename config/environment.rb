# Load the rails application
require File.expand_path('../application', __FILE__)

# Protect from xss attacks
Haml::Template.options[:escape_html] = true

# Initialize the rails application
GetvouchedCom::Application.initialize!
