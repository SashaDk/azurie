class Users::InvitationsController < Devise::InvitationsController
  # POST /resource/invitation
  def create
    self.resource = resource_class.invite!(params[resource_name], current_inviter)

    if resource.errors.empty?
      set_flash_message :notice, :send_instructions, :email => self.resource.email
      respond_with resource, :location => edit_user_path(resource)
    else
      respond_with_navigational(resource) { render_with_scope :new }
    end
  end
end
