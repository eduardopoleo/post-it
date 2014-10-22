class CommentsController < ApplicationController
  before_action :require_user
  before_action :set_categories

  def create
    # This are only for the create action. 
    # In order to display the form I need to define the Objects in the show action.
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    # this line is equivalent of saying 
    #@comment = Comment.new(params.require(:comment).permit(:body))
    #@comment.post = @post
    @comment.creator = current_user
    if @comment.save
      flash[:notice] = "You comment was posted!"
      redirect_to post_path(@post)
    else
      @categories = Category.all
      render 'posts/show'
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    @vote = Vote.create(creator: current_user, voteable: @comment, vote: params[:vote])
    respond_to do |format|
      format.js
    end
  end
end