class CategoriesController < ApplicationController
  before_action :require_user, except: [:show]
  before_action :set_categories

  def show
    @category = Category.find_by(slug: params[:id])  
    @posts = @category.posts
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = "Category Succesfully created"
      redirect_to posts_path
    else
      render :new
    end
  end

  private
  def category_params
    params.require(:category).permit!
  end
end