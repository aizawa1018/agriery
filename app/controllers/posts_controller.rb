class PostsController < ApplicationController
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

  private
  def post_params
    params.require(:posts_tag).permit(:title, :text, :name).merge(user_id: current_user.id)
  end
end
