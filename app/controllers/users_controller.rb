class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only:[:edit, :update]
  before_action :set_categories
  

  def new
    @user = User.new
  end

  def create
    @user = User.new(set_params)

    if @user.save
      flash[:notice] = "Your account was successfully created"
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render :new
    end

  end

  def show
    @posts = @user.posts
  end

  def edit
    
  end

  def update
    if @user.update(set_params)
      flash[:notice] = 'Your profile was successfully updated'
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def set_params
    params.require(:user).permit(:name, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user
      flash[:error] = 'Your are not allowed to modify that!'
      redirect_to user_path(@user)
    end
  end
end