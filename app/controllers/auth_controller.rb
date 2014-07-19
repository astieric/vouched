require 'rubygems'
require 'linkedin'

class AuthController < ApplicationController

  def index
    # get your api keys at https://www.linkedin.com/secure/developer
    client = LinkedIn::Client.new('yourAPIKey', 'yourSecretKey')
    request_token = client.request_token(:oauth_callback => 
                                      "http://#{request.host_with_port}/auth/callback")
    session[:rtoken] = request_token.token
    session[:rsecret] = request_token.secret

    redirect_to client.request_token.authorize_url

  end

  def callback
     client = LinkedIn::Client.new('d-nIOVnS_ngahsfM1_DrKxh2Pp3iIvMymJYAXlHg165rNTgNMVXuLE6jccSHxDVA', 'ecugeCTONAFf8WxVgf_iRBdsK0qmk7rTNf1oLSZnOHuUzE796iYpCRfqIrQ-ewnY')
    if session[:atoken].nil?
      pin = params[:oauth_verifier]
      atoken, asecret = client.authorize_from_request(session[:rtoken], session[:rsecret], pin)
      session[:atoken] = atoken
      session[:asecret] = asecret
      @user = current_user
      @user.linkedin_token = atoken
      @user.linkedin_secret = asecret
      @user.save

    else
      client.authorize_from_access(session[:atoken], session[:asecret])
    end
    @profile = client.profile
    @profile = client.profile(:fields => [:public_profile_url ])

   #We are going to hijack identities here.

    @identity = Identity.new
    @identity.user_id 	= current_user.id
    @identity.email   	= @profile.public_profile_url
    @identity.provider_id 	= 2
    @identity.confirmed_at  = Time.now


      if @identity.save
        flash[:notice] = 'Linked In account was successfully authenticated.'
      else
        flash[:error] = 'There was a problem authenticating your Linked In account.'
      end



  end
end