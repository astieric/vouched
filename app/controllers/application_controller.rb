require 'rest_client'

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :mailer_set_url_options
  rescue_from 'Acl9::AccessDenied', :with => :access_denied
  layout :layout_by_resource

  protected

  def layout_by_resource
    if (devise_controller? && action_name != "edit") || !user_signed_in?
      "splash"
    else
      "application"
    end
  end


 private  

   def mailer_set_url_options
     ActionMailer::Base.default_url_options[:host] = request.host_with_port
   end


   #fake login_required with Devise for Oauth-plugin
   def login_required
     user_signed_in?
   end

  def access_denied
    if current_user
      flash[:notice] = 'Access denied.'
      redirect_to access_denied_path
    else
      flash[:notice] = 'Access denied. Try to log in first.'
      redirect_to new_user_session_path
    end
  end

end
