class PagesController < ApplicationController

  def index
    redirect_to root_path and return if user_signed_in?
    render :layout => "splash"
  end

  def about
	@title = "About"
  end

  def home
    redirect_to index_path and return unless user_signed_in?
	@title = "Home"
	@vouchcount = Vouch.count
	@requestercount = Vouch.count(:requester_id, :distinct => true)
	@grantorcount = Vouch.count(:grantor_id, :distinct => true)
  end

  def help
	@title = "Help"
  end

  def service
    @title = "Terms of Service"
  end

  def privacy
	@title = "Privacy Policy"
  end

  def press
	@title = "Press"
  end

  def access_denied
	@title = "Access Denied"
  end
end
