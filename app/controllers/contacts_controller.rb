class ContactsController < ApplicationController
 before_filter :authenticate_user!
 skip_before_filter :verify_authenticity_token , :only => [:import]


  # GET /contacts
  # GET /contacts.xml
  def index
    case params[:contact_type]
      when "All Users"
        @contacts = Contact.includes(:identity).mine(current_user.id).where(Identity.arel_table[:user_id].not_eq(nil)).order("contacts.name").paginate(:page => params[:page] || 1, :per_page => 10)
      when "All Identities"
        @contacts = Contact.includes(:identity).mine(current_user.id).where(Identity.arel_table[:user_id].eq(nil)).order("contacts.name").paginate(:page => params[:page] || 1, :per_page => 10)
      when "Recent Users"
        @contacts = Contact.includes(:identity).mine(current_user.id).where(Identity.arel_table[:user_id].not_eq(nil)).order("contacts.name").paginate(:page => params[:page] || 1, :per_page => 10)
      when "Recent Identities"
        @contacts = Contact.includes(:identity).mine(current_user.id).where(Identity.arel_table[:user_id].not_eq(nil)).order("contacts.name").paginate(:page => params[:page] || 1, :per_page => 10)
      else
        @contacts = Contact.includes(:identity).mine(current_user.id).order("contacts.name").paginate(:page => params[:page] || 1, :per_page => 10)
    end
  
    @contact_type = params[:contact_type] || "All Contacts"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contacts }
    end
  end

  # GET /contacts/1
  # GET /contacts/1.xml
  def show
    @contact = Contact.where(:id => params[:id]).where(:user_id => current_user.id).first

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contact }
    end
  end

  # GET /contacts/new
  # GET /contacts/new.xml
  def new
    @contact = Contact.new

    @consumer_tokens=ConsumerToken.where(:user_id => current_user.id).all
    @services = OAUTH_CREDENTIALS.keys-@consumer_tokens.collect{|c| c.class.service_name}
    @identities = Identity.where(:user_id => current_user.id, :provider_id => [2,4,6] )

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contact }
    end
  end

  # GET /contacts/1/edit
  def edit
    @contact = Contact.where(:id => params[:id]).where(:user_id => current_user.id).first

  end

 # GET /contacs/import

  def import

     @type = params[:type]

     case params[:type]
      when "Google"
        Contact.google_import(current_user)
      when "Yahoo"
        Contact.yahoo_import(current_user)
      when "Live"
        Contact.live_import(current_user, request.request_parameters)
      when "Twitter"
        Contact.twitter_import(current_user)
      when "Facebook"
        options = {:headers => {'Content-Type' => 'application/json', 'Content-Length' => '0'}}
        HTTParty.put(URI.escape("http://localhost:9292/api/v1/import/#{params[:type]}/#{current_user.id}"), options)
      when "Linked In"
        options = {:headers => {'Content-Type' => 'application/json', 'Content-Length' => '0'}}
        HTTParty.put(URI.escape("http://localhost:9292/api/v1/import/#{params[:type]}/#{current_user.id}"), options)
      end
  end


  # POST /contacts
  # POST /contacts.xml
  def create
    #@consumer_tokens=ConsumerToken.where(:user_id => current_user.id).all
    #@services=OAUTH_CREDENTIALS.keys-@consumer_tokens.collect{|c| c.class.service_name}

    @contact = Contact.import_contact(current_user, params[:contact][:name], params[:contact][:email].downcase, 1, nil)


    respond_to do |format|
      if @contact 
        flash[:notice] = 'Contact was successfully created.'
        format.html { redirect_to(@contact) }
        format.xml  { render :xml => @contact, :status => :created, :location => @contact }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contacts/1
  # PUT /contacts/1.xml
  def update
    @contact = Contact.where(:id => params[:id]).where(:user_id => current_user).first

    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        flash[:notice] = 'Contact was successfully updated.'
        format.html { redirect_to(@contact) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.xml
  def destroy
    @contact = Contact.where(:id => params[:id]).where(:user_id => current_user).first
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to(contacts_url) }
      format.xml  { head :ok }
    end
  end
end
