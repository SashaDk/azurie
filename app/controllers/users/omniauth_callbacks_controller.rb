class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_apps
    @user = User.find_for_google_apps_open_id(env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google Apps"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.google_apps_data"] = env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def facebook
    render :text => env["omniauth.auth"].to_yaml
  end

  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
end
