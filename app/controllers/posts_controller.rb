class PostsController < ApplicationController
  before_action :require_user

  def show
    @media = PostMedia.find_by(current_user.token, params["id"])
  end
end
