class EducationsController < ApplicationController
   before_filter :authenticate_user!

  # GET /educations
  # GET /educations.xml
  def index
    @educations = Education.where(:resource_id => current_user.id).where("provider_id = 0")

    @facebook_educations = Array.new
    @linked_in_educations = Array.new

    @facebook_educations =  Education.where("resource_id IN ( #{ current_user.identities.where("provider_id = 4").collect{|x| "'" + x.id + "'"}.join(", ") } )") unless current_user.identities.where("provider_id = 4").size == 0
    @linked_in_educations = Education.where("resource_id IN ( #{ current_user.identities.where("provider_id = 6").collect{|x| "'" + x.id + "'"}.join(", ") } )") unless current_user.identities.where("provider_id = 6").size == 0

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @educations }
    end
  end

  # GET /educations/1
  # GET /educations/1.xml
  def show
    @education = Education.where(:resource_id => current_user.id, :id => params[:id]).first

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @education }
    end
  end

  # GET /educations/new
  # GET /educations/new.xml
  def new
    @education = Education.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @education }
    end
  end

  # GET /educations/1/edit
  def edit
    @education = Education.where(:resource_id => current_user.id, :id => params[:id]).first

  end

  # POST /educations
  # POST /educations.xml
  def create
    @education = Education.new(params[:education])
    @education.resource_id = current_user.id
    @education.resource_type = 'User'
    @education.provider = 0    

    respond_to do |format|
      if @education.save
        format.html { redirect_to(educations_url, :notice => 'Education was successfully added.') }
        format.xml  { render :xml => @education, :status => :created, :location => @education }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @education.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /educations/1
  # PUT /educations/1.xml
  def update
    @education = Education.where(:resource_id => current_user.id, :id => params[:id]).first

    respond_to do |format|
      if @education.update_attributes(params[:education])
        format.html { redirect_to(@education, :notice => 'Education was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @education.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /educations/1
  # DELETE /educations/1.xml
  def destroy
    @education = Education.where(:resource_id => current_user.id, :id => params[:id]).first
    @education.destory

    respond_to do |format|
      format.html { redirect_to(educations_url) }
      format.xml  { head :ok }
    end
  end
end

