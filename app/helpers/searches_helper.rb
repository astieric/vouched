module SearchesHelper
  def best_hit_description(hit)
    if highlight = hit.highlight(:email)
      highlight.format { |word| "<strong>#{word}</strong>" }
    else
      h(hit.result.email)
    end
  end
end