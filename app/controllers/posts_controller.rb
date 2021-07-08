class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :show]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def new
    @poststag = PostsTag.new
  end

  def create
    @poststag = PostsTag.new(post_params)
    if @poststag.valid?
      @poststag.save
      return redirect_to root_path
    else
      render "new"
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
  end

  def edit
  end

  def show
    @comment = Comment.new
    @comments = @post.comment.includes(:user)
  end

  private
  def post_params
    params.require(:posts_tag).permit(:title, :text, :name).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
