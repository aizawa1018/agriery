class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :show, :update, :destroy]
  before_action :move_to_index, except: [:index, :show, :search]

  def index
    @posts = Post.includes(:user).order(created_at: :desc)
  end

  def new
    @poststag = PostsForm.new
  end

  def create
    @poststag = PostsForm.new(post_params)
    # if #@poststag.valid?
    if @poststag.save
      return redirect_to root_path
    else
      render "new"
    end
  end

  def destroy
    @post.destroy
  end

  def edit
    load_post
    @poststag = PostsForm.new(post: @post)
  end

  def update
    load_post

    @poststag = PostsForm.new(post_params, post: @post)
    if @poststag.save
       redirect_to root_path
    else
      render :edit
    end
  end

  def show
    @comment = Comment.new
    @comments = @post.comment.includes(:user)
  end

  def search
    @posts = Post.search(params[:keyword])
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :name).merge(user_id: current_user.id)
  end

  # def update_params
  #   params[:post].permit(:title, :name, :text).merge(user_id: current_user.id, post_id: params[:id])
  # end

  def load_post
    @post = current_user.posts.find(params[:id])
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
