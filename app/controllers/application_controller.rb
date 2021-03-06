class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue
      @current_user = nil
    end
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash['error'] = "You must be logged in to perform that action."
      redirect_to root_path
    end
  end

  def require_admin
    access_denied unless logged_in? && current_user.admin?
  end

  def access_denied
    flash['error'] = 'Only allowed for administrators.'
    redirect_to root_path
  end

end
