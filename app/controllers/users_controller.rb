class UsersController < ApplicationController
  before_action :require_user

  def show
    @user = User.find_by(username: params[:username])
    @info = UserInfo.all(current_user.token)
    @media = UserMedia.all(current_user.token)
  end
end
