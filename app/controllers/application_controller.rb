class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale
 
  def set_locale
    I18n.locale = cookies[:locale] || I18n.default_locale
  end  

  rescue_from CanCan::AccessDenied do |exception|
    render :file => "#{Rails.root}/public/401.html", :status => 401
  end

  def authenticate_inviter!
    authorize! :create, User
    current_user
  end

end
