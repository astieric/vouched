class ConfirmationsController < ApplicationController
  include Devise::Controllers::InternalHelpers

  before_filter :authenticate_user! , :only => [:show]


  # GET /resource/confirmation/new
  def new
    build_resource
    render_with_scope :new
  end

  # POST /resource/confirmation
  def create
	new_identity = Identity.find_or_create_by_email(params[:identity][:email], {:provider_id => 1})
	new_identity.save
    self.resource = resource_class.send_confirmation_instructions(params[resource_name])

    if resource.errors.empty?
      set_flash_message :notice, :send_instructions
      redirect_to identities_path
    else
      render_with_scope :new
    end
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    identity = Identity.find_by_confirmation_token(params[:confirmation_token])

    self.resource = resource_class.confirm_by_token(params[:confirmation_token])

    if resource.errors.empty?
      set_flash_message :notice, :confirmed
       self.resource.user_id = current_user.id
       self.resource.user_node = current_user.user_node
       self.resource.save

       #TO-DO: Create procedure to replace identity node with user node
       #Vouch.update_all :requester_id => current_user.id, :requester_type => "User", "requester_id = #{identity.id}"
       #Vouch.update_all :grantor_id => current_user.id, :grantor_type => "User", "grantor_id = #{identity.id}"

       # If the identity has the vouches, but the user does not, then update identity to be user. 
       sql = "UPDATE vouches v LEFT JOIN vouches v2 on v.term_id = v2.term_id and v.grantor_id = v2.grantor_id SET v.requester_id = \"#{current_user.id}\", v.requester_type = 'User' WHERE v.requester_id = \"#{identity.id}\" AND v2.id IS NULL"
       Vouch.connection.update(sql)

       sql = "UPDATE vouches v LEFT JOIN vouches v2 on v.term_id = v2.term_id and v.requester_id = v2.requester_id SET v.grantor_id = \"#{current_user.id}\", v.grantor_type = 'User' WHERE v.grantor_id = \"#{identity.id}\" AND v2.id IS NULL"
       Vouch.connection.update(sql)

       # If both the identity and the user have the vouches, then update status to be the better of the two.
       sql = "UPDATE vouches v LEFT JOIN vouches v2 on v.term_id = v2.term_id and v.grantor_id = v2.grantor_id SET v.status_id = v2.status_id WHERE v.requester_id = \"#{current_user.id}\" AND v2.requester_id = \"#{identity.id}\" AND v2.status_id < v.status_id"
       Vouch.connection.update(sql)

       sql = "UPDATE vouches v LEFT JOIN vouches v2 on v.term_id = v2.term_id and v.requester_id = v2.requester_id SET v.status_id = v2.status_id WHERE v.grantor_id = \"#{current_user.id}\" AND v2.requester_id = \"#{identity.id}\" AND v2.status_id < v.status_id"
       Vouch.connection.update(sql)


       Vouch.delete_all("requester_id = \"#{identity.id}\"")
       Vouch.delete_all("grantor_id = \"#{identity.id}\"")

	redirect_to identities_path
    else
      render_with_scope :new
    end
  end
end