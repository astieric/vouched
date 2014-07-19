class ActiveRecord::Base
  def scope(name, scope_options = {})
    @scope_name = name
    super name, scope_options
  end

  def scope_name
    (@scope_name || "")
  end
end
