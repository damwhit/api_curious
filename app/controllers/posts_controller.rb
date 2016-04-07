class PostsController < ApplicationController
  before_action :require_user

  def show
    @post = PostMedia.find_by(current_user.token, params["id"])
  end

  # def index
  #   @posts = PostMedia.all(current_user.token)
  #   @posts = @posts.paginate(page: params[:page], per_page: 10)
  #   respond_to do |format|
  #     format.html
  #     format.js
  #   end
  # end

  def index
    get_and_show_posts
  end

  def index_with_button
    get_and_show_posts
  end

private

  def get_and_show_posts
    @posts = PostMedia.all(current_user.token)
    @posts = @posts.paginate(page: params[:page], per_page: 10)
    respond_to do |format|
        format.html
        format.js
    end
  end
end
