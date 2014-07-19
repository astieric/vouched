class EmploymentsController < ApplicationController
   before_filter :authenticate_user!

  # GET /employments
  # GET /employments.xml
  def index
    @employments = Employment.where(:resource_id => current_user.id).where("provider_id = 0")

    @facebook_employments = Array.new
    @linked_in_employments = Array.new

    @facebook_employments =  Employment.where("resource_id IN ( #{ current_user.identities.where("provider_id = 4").collect{|x| "'" + x.id + "'"}.join(", ") } )") unless current_user.identities.where("provider_id = 4").size == 0
    @linked_in_employments = Employment.where("resource_id IN ( #{ current_user.identities.where("provider_id = 6").collect{|x| "'" + x.id + "'"}.join(", ") } )") unless current_user.identities.where("provider_id = 6").size == 0

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @employments }
    end
  end

  # GET /employments/1
  # GET /employments/1.xml
  def show
    @employment = Employment.where(:resource_id => current_user.id, :id => params[:id]).first

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @employment }
    end
  end

  # GET /employments/new
  # GET /employments/new.xml
  def new
    @employment = Employment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @employment }
    end
  end

  # GET /employments/1/edit
  def edit
    @employment = Employment.where(:resource_id => current_user.id, :id => params[:id]).where("provider_id = 0").first

  end

  # POST /employments
  # POST /employments.xml
  def create
    @employment = Employment.new(params[:education])
    @employment.resource_id = current_user.id
    @employment.resource_type = 'User'
    @employment.provider = 0    

    respond_to do |format|
      if @employment.save
        format.html { redirect_to(employments_url, :notice => 'Employment was successfully added.') }
        format.xml  { render :xml => @employment, :status => :created, :location => @employment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @employment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /employments/1
  # PUT /employments/1.xml
  def update
    @employment = Employment.where(:resource_id => current_user.id, :id => params[:id]).first

    respond_to do |format|
      if @employment.update_attributes(params[:employment])
        format.html { redirect_to(@employment, :notice => 'Employment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @employment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /employments/1
  # DELETE /employments/1.xml
  def destroy
    @employment = Employment.where(:resource_id => current_user.id, :id => params[:id]).first
    @employment.destory

    respond_to do |format|
      format.html { redirect_to(employments_url) }
      format.xml  { head :ok }
    end
  end
end

