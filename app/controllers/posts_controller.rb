class PostsController < ApplicationController
  before_action :set_post, only: [:show,:edit,:update, :vote]
  before_action :set_categories

  before_action :require_user, except:[:index, :show]
  
  def index
    @posts = Post.all
  end

  def show
    # this new comment I have to set in order for the show action to show it.
    # I do not need to define the @post because it's already defined.
    @comment = Comment.new
    # params is a hash where all the request info is stored.
    # So it basically takes all the info from one action to the other
    # @post = Post.find(params[:id])
  end

  def new

    # this post has to be defined only if we are using 
    # the backend -forms because we need to pass it to
    # the form so that it knows what object are we talking about
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user
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
  end

  def update

    if @post.update(post_params)
      flash[:notice] = "Post successfully updated"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def vote
    @vote = Vote.create(creator: current_user, voteable: @post, vote: params[:vote])

    respond_to do |format|
        format.js
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
    @post = Post.find_by(slug: params[:id])
  end
end
