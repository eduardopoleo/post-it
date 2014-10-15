class SessionsController < ApplicationController
  before_action :set_categories
  def new
    
  end

  def create
    user = User.where(name: params[:name]).first

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = 'You have successfully logged in.'
      redirect_to root_path
    else
      flash[:error] = 'Your user-name or password do not match.'
      redirect_to login_path  
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have successfully logged out"
    redirect_to root_path
  end

end
