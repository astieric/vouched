#
#  Vouch, root of the system itself.
#   Vouches have several states:
#     - requested: vouch was requested, but unconfirmed
#     - confirmed: vouch was requested and confirmed or just given
#     - rejected: vouch was requested and then rejected
#
class Vouch < ActiveRecord::Base
  has_uuid

  validates :term_id, :presence => true, :uniqueness => {:scope => [:requester_id, :grantor_id], :message => "has been vouched for already"}

  is_stateful :by => :status_id, :initial => :requested do 
    transition :name => :confirm, :from => :requested, :to => :confirmed
    transition :name => :reject, :from => :requested, :to => :rejected
    transition :name => :pending, :from => :confirmed, :to => :requested
  end

  scope :all_vouches, lambda { |user_id| where("grantor_id = ? OR requester_id = ?", user_id, user_id).order("updated_at DESC").includes(:requester, :grantor) }

  scope :pending,   lambda { |user_id| where(:grantor_id => user_id).where(:status_id => "requested").order("updated_at DESC").includes(:requester, :grantor) }
  scope :requested, lambda { |user_id| where(:requester_id => user_id).where(:status_id => "requested").order("updated_at DESC").includes(:requester, :grantor, :term) }
  scope :granted,   lambda { |user_id| where(:requester_id => user_id).where(:status_id => "confirmed").order("updated_at DESC").includes(:requester, :grantor) }
  scope :received,  lambda { |user_id| where(:grantor_id => user_id).where(:status_id => "confirmed").order("updated_at DESC").includes(:requester, :grantor) }

  belongs_to :requester, :polymorphic => true
  belongs_to :grantor, :polymorphic => true
  belongs_to :term

  def set_requester_type
    if !requester.nil?
      requester_type = requester.class
    end
  end

  def term_name  
    unless term.nil?
      term.name
    end
  end 

  def term_name=(name)  
    self.term = Term.find_or_create_by_name(name)
  end  

  def motivational_message for_user
    if parent.is? for_user
      "No pending vouches.  You should request some, because it's ok to toot your own horn."      
    else
      "No pending vouches, maybe they're shy.  Help them get started with a vouch."      
    end
  end

  def is_confirmed?
    self.status_id == "confirmed"
  end

  def is_requested?
    self.status_id == "pending"
  end

  def is_rejected?
    self.status_id == "rejected"
  end


end
