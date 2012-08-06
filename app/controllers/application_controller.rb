class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale
  before_filter :store_location
  layout :layout_by_resource

  def layout_by_resource
    if params[:controller] =~ /devise\/oauth2/
      "test"
    else
      "application"
    end
  end

  def set_locale
    I18n.locale = cookies[:locale] || I18n.default_locale
  end  

  def store_location
    unless [omniauth_authorize_path(:user, :facebook), omniauth_authorize_path(:user, :facebook), omniauth_authorize_path(:user, :google_apps)].include? request.path
      cookies[:location] = request.url
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    render :file => "#{Rails.root}/public/401.html", :status => 401
  end

  def authenticate_inviter!
    authorize! :create, User
    current_user
  end

  def after_sign_in_path_for(resource)
    logger.info "\n=========================#{request.env['omniauth.origin']}===========================\n\n"
    logger.info "\n=========================#{stored_location_for(resource)}===========================\n\n"
    return cookies[:location] || stored_location_for(resource) || root_path
  end
end
