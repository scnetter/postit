class CommentsController < ApplicationController

  before_action :require_user, only: [:create, :vote]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.creator = current_user

    if @comment.save
      flash['notice'] = 'Your comment was created.'
      redirect_to post_path(@post)
    else
      render '/posts/show'
    end
  end

  def vote

    @vote = Vote.create(voteable: Comment.find(params[:id]),
      creator: current_user, vote: params[:vote])

    unless @vote.valid? then flash['error'] = 'You can only vote once.' end

    redirect_to :back

  end
end
