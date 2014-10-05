class PostsController < ApplicationController
  before_action :set_post, only: [:show,:edit,:update]
  before_action :set_categories
  
  def index
    #@categories = Category.all
    @posts = Post.all
  end

  def show
    # params is a hash where all the request info is stored.
    # So it basically takes all the info from one side of the request to the other
    # @post = Post.find(params[:id])
  end

  def new

    # this post has to be defined only if we are using 
    # the backend -forms because we need to pass it to
    # the form so that it knows what object are we talking about
    @post = Post.new
  end

  def create
    # Pure HTML & regular helpers

    # @post= Post.new
    # @post.title = params[:title]
    # @post.url = params[:url]
    # @post.description = params[:description]
    # @post.save
    @post = Post.new(post_params)

    if @post.save
      flash[:notice] = "Post successfully created"
      redirect_to post_path(@post)
    else
      # render does not count as new request
      # so @post.errors stored in here are passed to the new view
    render :new
    end
  end

  def edit
    # @post = Post.find(params[:id])
  end

  def update
    # @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:notice] = "Post successfully updated"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  # here starts the strong params definition.
  private

  def post_params
    # Strong parameters are there just to regulate what parameter are mass updated
    # Require is tells the data base what params are needed 
    # Permit tells which are allowed for mass updating
    # The constructions params.require(:post) assumes a nested structure
    params.require(:post).permit! 

  end

  def set_post
    @post = Post.find(params[:id])
  end

  def set_categories
    @categories = Category.all
  end
end
