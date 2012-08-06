class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale
  before_filter :mobile_auth
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

  def mobile_auth
    cookies[:mobile_auth] = true if params[:mobile_auth].present?
  end

  rescue_from CanCan::AccessDenied do |exception|
    render :file => "#{Rails.root}/public/401.html", :status => 401
  end

  def authenticate_inviter!
    authorize! :create, User
    current_user
  end

  def after_sign_in_path_for(resource)
    sign_in_url = url_for(:action => 'new', :controller => 'sessions', :only_path => false, :protocol => 'http')
    if (request.referer == sign_in_url)
      super
    else
      request.referer || stored_location_for(resource) || root_path
    end
  end
end
