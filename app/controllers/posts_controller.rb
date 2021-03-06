class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show, :vote]
  before_action :is_owner?, only: [:edit, :show]
  helper_method :is_owner?

  def index
    @posts = Post.all.sort_by{ |post| post.total_votes }.reverse
  end

  def show
    @comment = Comment.new
  end

  def new
      @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user

    if @post.save
      flash['notice'] = "#{@post.creator.username}, your post was created."
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit; end

  def update

    if @post.update(post_params)
      flash['notice'] = "Your post was updated."
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def vote
    @vote = Vote.create(voteable: @post, creator: current_user,
     vote: params[:vote])
    # unless @vote.valid? then flash['error'] = 'You can only vote once.' end
    # redirect_to :back
    respond_to do |format|
      
      format.html {
        unless @vote.valid? then flash['error'] = 'You can only vote once.' end
        redirect_to :back, notice: 'Your vote was counted.'
      }

      format.js do
      end
    end
  end

  def is_owner?
    current_user.id == @post.creator.id
  end

  private
  def set_post
    @post = Post.find_by_slug(params[:id])
  end

  def post_params
    params.require(:post).permit(:title,:url,:description, category_ids: [])
  end
end
