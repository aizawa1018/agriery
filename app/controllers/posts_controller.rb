class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :show, :update, :destroy]
  before_action :move_to_index, except: [:index, :show, :search]

  def index
    @posts = Post.includes(:user).order(created_at: :desc)
  end

  def new
    @poststag = PostsTag.new
  end

  def create
    binding.pry
    @poststag = PostsTag.new(post_params)
    if @poststag.valid?
      @poststag.save
      return redirect_to root_path
    else
      render "new"
    end
  end

  def destroy
    @post.destroy
  end

  def edit
    @poststag = PostsTag.new(title: @post.title, text: @post.text)
  end

  def update
    @poststag = PostsTag.new(update_params,title: @post.title, text: @post.text)
    if @poststag.valid?
       @poststag.update
       redirect_to root_path
    else
      render :edit
    end
  end

  def show
    @poststag = PostsTag.new(title: @post.title, text: @post.text)
    @comment = Comment.new
    @comments = @post.comment.includes(:user)
  end

  def search
    @posts = Post.search(params[:keyword])
  end

  private

  def post_params
    params.permit(:title, :text, :name).merge(user_id: current_user.id)
  end

  def update_params
    params.permit(:title, :text, :name).merge(user_id: current_user.id, post_id: params[:id])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
