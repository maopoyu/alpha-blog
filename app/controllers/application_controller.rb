class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?
  around_action :switch_locale
 
  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
  	!!current_user
  end

  def require_user
  	if !logged_in?
  	  flash[:danger] = "You must be logged in to perform that action"
  	  redirect_to root_path
  	end
  end

end
