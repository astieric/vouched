class Archetype < ActiveRecord::Base
  # 
  #  Behavior
  #

  has_uuid
  has_friendly_id :name
  has_terms
  has_vouches_requested   # Archetypes cannot be the grantor of a vouch, only the requester.
  has_paper_trail :ignore => [:public]
  has_lists
  has_search_type
  with_name_like

  belongs_to :user
  
  searchable do
    string  :search_type, :stored => true
    text    :name,        :stored => true,      :boost => 2.0
    text    :abstract,    :stored => true
    string  :user_id,     :references => User
    text    :description
    time    :created_at,  :trie => true
    time    :updated_at,  :trie => true
    string  :terms, :multiple => true do
      terms.map { |term| term.name }  unless terms.blank?
    end
  end

end
