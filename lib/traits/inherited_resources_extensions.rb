class InheritedResources::Base
  def current_page
    params[:page] || 1
  end
end
