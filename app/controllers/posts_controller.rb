class PostsController < ApplicationController
  before_action :require_user

  def create
    CommentMedia.create(current_user.token, params[:id], params[:comment])
    redirect_to post_path(params[:id])
  end

  def show
    require "pry"; binding.pry
    @post = PostMedia.find_by(current_user.token, params["id"])
  end

  def index
    @posts = PostMedia.all(current_user.token)
  end

  def destroy
    CommentMedia.destroy(current_user.token, params[:id], params[:comment_id])
    redirect_to post_path(params[:id])
  end
end
