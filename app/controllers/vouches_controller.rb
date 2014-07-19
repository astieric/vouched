class VouchesController < InheritedResources::Base
  polymorphic_belongs_to :user, :archetype, :job, :identity
  before_filter :authenticate_user!

  # GET /vouches
  # GET /vouches.xml
  def index
    type =  params[:view] || "all_vouches"
    if [ "all_vouches", "received", "granted", "requested", "pending" ].include?(type)
      @vouches = Vouch.send(type, parent.id).paginate(:page => params[:page] || 1, :per_page => 10)
      @vouch_type = type
    end
    
  end

  # POST /vouches
  def create
    @vouch = Vouch.new params[:vouch]

    if vouches_requested_page? 
      @vouch.requester_id   = current_user.id
      @vouch.requester_type = current_user.class.to_s
      @vouch.grantor_id     = parent.id
      @vouch.grantor_type   = parent.class.to_s
    else
      @vouch.status_id      = "confirmed"
      @vouch.requester_id   = parent.id
      @vouch.requester_type = parent.class.to_s
      @vouch.grantor_id     = current_user.id
      @vouch.grantor_type   = current_user.class.to_s
    end
   
    respond_to do |format|
      if @vouch.save
        resource_term = @vouch.term.resource_terms.new 
        resource_term.resource_id = @vouch.requester_id
        resource_term.resource_type = @vouch.requester_type
        resource_term.save
        format.js   { render :action => "new", :content_type => 'text/javascript'}
        format.html { redirect_to new_polymorphic_path([parent,Vouch.new], :view => params[:view]) }
      else
        format.html { render :new }
      end
    end
  end

  # PUT /vouches/1
  # PUT /vouches/1.xml
  def update
    @vouch = Vouch.find(params[:id])

    if current_user.id == @vouch.grantor_id
      case params[:commit]
        when "Approve"
          @vouch.confirm 
        when "Pending"
          @vouch.pending
        when "Deny"
          @vouch.reject
       end
    end

    respond_to do |format|
      if @vouch.save
        format.js   { render :action => "update", :content_type => 'text/javascript'}
        format.html { redirect_to polymorphic_path([parent,Vouch.new]), :notice => 'Vouch was successfully updated.' }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @vouch.errors, :status => :unprocessable_entity }
        format.js   { render :partial => @vouch, :layout => false }
      end
    end
  end

  def preview
    @term = Vouch.where(:id => params[:id]).first.term
    type =  params[:view] || "all_vouches"
    if [ "all_vouches", "received", "granted", "requested", "pending" ].include?(type)
      @vouches = Vouch.send(type, params[:parent_id]).where(:term_id => @term.id).paginate(:page => params[:page] || 1, :per_page => 10)
      @vouch_type = type
    end
    render :layout => false
  end

  def new

  end

private
  def vouches_requested_page?
    params[:view] == "requested"
  end

  def vouches_given_page?
    params[:view] == "given"
  end

  def resource
  end

  def parent
    case
      when params[:identity_id]  then Identity.find(params[:identity_id])
      when params[:user_id]      then User.find(params[:user_id])
      when params[:archetype_id] then Archetype.find(params[:archetype_id])
    end    
  end  

  def parent_url(parent)
    case
      when params[:identity_id]  then identity_url(parent)
      when params[:user_id]      then user_url(parent)
      when params[:archetype_id] then archetype_url(parent)
    end    
  end

  def parent_name(parent)
    case
      when params[:identity_id]  then parent_object.name
      when params[:user_id]      then parent_object.username
      when params[:archetype_id] then parent_object.name
    end    
  end

end
