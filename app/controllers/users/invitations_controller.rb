class Users::InvitationsController < Devise::InvitationsController
  # POST /resource/invitation
  def create
    self.resource = resource_class.invite!(params[resource_name], current_inviter)
    
    respond_to do |format|
      if resource.errors.empty?
        set_flash_message :notice, :send_instructions, :email => self.resource.email
        format.html { redirect_to edit_user_path(resource) }
        format.xml  { head :ok }
      else
        format.html { render_with_scope :new }
        format.xml  { render :xml => resource.errors, :status => :unprocessable_entity }
      end
    end
  end
end 
