class IdentitiesController < ApplicationController
   before_filter :authenticate_user!

  # GET /identities
  # GET /identities.xml
  # This action is now My Identitities
  # TODO: Actually, that should be moved to user/identities controller. Shouldn't be here. Only generic identity actions should be here.
  def index
    @identities = Identity.where(:user_id => current_user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @identities }
    end
  end

  # GET /identities/1
  # GET /identities/1.xml
  def show
    #@identity = Identity.find(params[:id])
    @identity = Identity.where(:id => params[:id]).first

    @vouches = @identity.vouches_requested.group("term_id").count

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @identity }
    end
  end

  # GET /identities/new
  # GET /identities/new.xml
  def new
    @identity = Identity.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @identity }
    end
  end

  # GET /identities/1/edit
  def edit
    @identity = Identity.where(:user_id => current_user.id, :id => params[:id]).first

  end

  # POST /identities
  # POST /identities.xml
  def create
    omniauth = request.env["omniauth.auth"]
    provider = Provider.find_by_name(omniauth['provider'])
    @identity = Identity.find_by_provider_id_and_email(provider.id, omniauth['uid'].to_s)

    if @identity 
      @identity.user = current_user
    else
      @identity = Identity.new(:user => current_user, :provider => provider, :email => omniauth['uid'].to_s)
    end

    @identity.apply_omniauth omniauth
    respond_to do |format|
      if @identity.save

        if provider.id == 4
          client = FBGraph::Client.new(:client_id => FACEBOOK_ID, :secret_id => FACEBOOK_SECRET, :token => @identity.token)
          @identity.import_facebook(client.selection.me.info!)
        end

        if provider.id == 6
          client = LinkedIn::Client.new(LINKED_IN_ID, LINKED_IN_SECRET)
          client.authorize_from_access(@identity.token, @identity.secret)
          @identity.import_linked_in(client.profile(:fields => [:location, :headline, :summary, :positions, :educations]))
        end

        format.html { redirect_to(identities_url, :notice => 'Identity was successfully added.') }
        format.xml  { render :xml => @identity, :status => :created, :location => @identity }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @identity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /identities/1
  # PUT /identities/1.xml
  def update
    @identity = Identity.where(:user_id => current_user.id, :id => params[:id]).first

    respond_to do |format|
      if @identity.update_attributes(params[:identity])
        format.html { redirect_to(@identity, :notice => 'Identity was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @identity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /identities/1
  # DELETE /identities/1.xml
  def destroy
    @identity = Identity.where(:user_id => current_user.id, :id => params[:id]).first
    @identity.user_id = nil
    @identity.save

    respond_to do |format|
      format.html { redirect_to(identities_url) }
      format.xml  { head :ok }
    end
  end

  def preview
    @identity = Identity.where(:id => params[:id]).first

    render :layout => false
  end

end