class CommentsController < ApplicationController
  def create
    # This are only for the create action. 
    # In order to display the form I need to define the Objects in the show action.
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.creator = User.find(1)
    # this line is equivalent of saying 
    #@comment = Comment.new(params.require(:comment).permit(:body))
    #@comment.post = @post

    if @comment.save
      flash[:notice] = "You comment was posted!"
      redirect_to post_path(@post)
    else
      @categories = Category.all
      render 'posts/show'
    end

  end
end