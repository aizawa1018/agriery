class UsersController < ApplicationController
  def show
    #@post = Post.find_by(id: params[:id])
    user = User.find_by(id: params[:id])
    @nickname = current_user.nickname
    @posts = current_user.posts
  end
end
