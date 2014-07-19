# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include Acl9Helpers

  def inject_js(path, local_varaibles = {})
    content_tag('script', :type => 'text/javascript') do
      concat("window.addEvent('domready', function() {")
      str = render :file => "inject/#{path}.js"

      local_varaibles.each do |k,v|
        str.gsub!("%#{k}%", v)
      end

      concat(str)
      concat("})")
    end
  end #inject_js

  def get_search_options
    { 'All'        => 'all',
      'Users'      => 'users', 
      'Vouches'    => 'vouches',
      'Jobs'       => 'jobs',
      'Archetypes' => 'archetypes',
      'Companies'  => 'companies' }
  end

  # Return a title on a per-page basis.
  # http://www.zetetic.net/blog/2010/05/18/pretty-page-title-in-rails-3/

  def yield_for(content_sym, default)
    output = content_for(content_sym)
    output = default if output.blank?
    output
  end

  def display_standard_flashes(message = 'There were some problems with your submission:')
    if flash[:success]
      flash_to_display, level = flash[:success], 'notice'
    elsif flash[:notice]
      flash_to_display, level = flash[:notice], 'notice'
    elsif flash[:warning]
      flash_to_display, level = flash[:warning], 'warning'
    elsif flash[:failure]
      flash_to_display, level = flash[:failure], 'error'
    elsif flash[:error]
      level = 'error'
      if flash[:error].instance_of?(ActiveRecord::Errors) || flash[:error].is_a?(Hash)
        flash_to_display = message
        flash_to_display << activerecord_error_list(flash[:error])
      else
        flash_to_display = flash[:error]
      end
    else
      return
    end
    content_tag 'div', content_tag(:span, sanitize(flash_to_display)), :id => "flash", :class => "#{level}"
  end

  def activerecord_error_list(errors)
    error_list = '<ul class="error_list">'
    error_list << errors.collect do |e, m|
      "<li>#{e.humanize unless e == "base"} #{m}</li>"
    end.to_s << '</ul>'
    error_list
  end

  def link_to_edit(path)
    link_to raw('Edit <span class="pencil"></span>'.html_safe), path, :class => 'button button-gray no-text'
  end

  def link_to_destroy(path)
    link_to raw('Del <span class="bin"></span>'.html_safe), path, :confirm => 'Are you sure?', :method => :delete, :class => 'button button-gray no-text'
  end

end
