puts '=> Configuring Sass'

Sass::Plugin.options[:style] = :compact
Sass::Plugin.options[:property_syntax] = :new
Sass::Plugin.remove_template_location("#{Rails.root}/public/stylesheets/sass")
Sass::Plugin.add_template_location("#{Rails.root}/app/stylesheets")
