class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.creator = User.first

    if @comment.save
      @post.comments << @comment
      flash['notice'] = 'Your comment was created.'
      redirect_to post_path(@post)
    else
      render '/posts/show'
    end
  end
end