class Users::InvitationsController < Devise::InvitationsController
  # POST /resource/invitation
  def create
    self.resource = resource_class.invite!(params[resource_name], current_inviter)    
    respond_to do |format|
      if resource.errors.empty?
        resource.make_expert! if params[:user][:role] == 'expert'
        resource.make_admin! if params[:user][:role] == 'admin'
        if params[:user][:role] == 'expert' 
          UserMailer.expert_invitation_instructions(resource).deliver
        elsif params[:user][:role] == 'guest' 
          UserMailer.guest_invitation_instructions(resource).deliver
        else
          UserMailer.invitation_instructions(resource).deliver
        end
        set_flash_message :notice, :send_instructions, :email => self.resource.email
        format.html { redirect_to edit_user_path(self.resource) }
        format.xml  { head :ok }
      else
        format.html { render_with_scope :new }
        format.xml  { render :xml => resource.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /resource/invitation
  def update
    self.resource = resource_class.accept_invitation!(params[resource_name])

    if resource.errors.empty?
      set_flash_message :notice, :accept_instructions, :email => self.resource.email
      sign_in(:user, resource)
      redirect_to edit_user_path(resource)
    else
      render :action => :edit 
    end
  end

  def after_accept_path_for(resource)
    '/about' #user_path(resource)
  end
end 
