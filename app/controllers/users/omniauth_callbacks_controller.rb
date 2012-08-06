class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_apps
    @user = User.find_for_google_apps_open_id(env["omniauth.auth"], current_user)

    if cookies[:mobile_auth].blank?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google Apps"
      sign_in :user, @user
      redirect_to after_sign_in_path_for(@user)
    else
      cookies[:mobile_auth] = nil
      render :json => {:auth_token => @user.authentication_token}
    end
  end

  def facebook
    @user = User.find_for_facebook_omniauth(env["omniauth.auth"], current_user)

    if cookies[:mobile_auth].blank?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in :user, @user
      redirect_to after_sign_in_path_for(@user)
    else
      cookies[:mobile_auth] = nil
      render :json => {:auth_token => @user.authentication_token}
    end
  end

  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
end
