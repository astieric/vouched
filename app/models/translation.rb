class Translation < ActiveRecord::Base
  validates :term_id,   :presence => true
  validates :phrase_id, :presence => true

  belongs_to :term
  belongs_to :phrase

  validates :priority , :uniqueness => {:scope => [:term_id, :phrase_id], :message => "should put it lower on the list"}

end