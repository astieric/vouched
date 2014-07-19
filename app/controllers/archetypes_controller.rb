class ArchetypesController < InheritedResources::Base
  def vouches
    @resource = Archetype.find(params[:id])
    render "vouches", :layout => false
  end

  def autocomplete 
    if request.xhr?
      render :json => (Archetype.with_name_like params[:name]).to_json
    end
  end

  def create
    terms = params["archetype"]["terms"]
    archetype = Archetype.create(params["archetype"].except([ :terms, :vouches_requested ]))
    terms.each do |t| 
      archetype.vouches_requested << Vouch.create(:term => Term.find_by_id(t))
    end
    archetype.save
    redirect_to archetype 
  end

  protected

  def collection
    @archetype ||= end_of_association_chain.paginate(:page => current_page, :per_page => 20)
  end

  def per_page
    20
  end
end
