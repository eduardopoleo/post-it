class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def set_categories
    @categories = Category.all
  end

  #these two are used to control the UI
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end
  # this used to shut down the actions that from the url.
  def require_user
    if !logged_in?
      flash[:error] = "Must be logged in."
      redirect_to root_path
    end
  end

end
