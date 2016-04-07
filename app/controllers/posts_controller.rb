class PostsController < ApplicationController
  before_action :require_user

  def show
    @post = PostMedia.find_by(current_user.token, params["id"])
  end

  def index
    @posts = PostMedia.all(current_user.token)
  end
end
