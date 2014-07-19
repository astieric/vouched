class TermsController < ApplicationController
  def autocomplete 
    if request.xhr?
      render :json => (Term.with_name_like params[:name]).to_json
    end
  end
end
