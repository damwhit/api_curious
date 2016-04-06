class SessionsController < ApplicationController
  def create
    if user = User.from_omniauth(request.env["omniauth.auth"])
      session[:user_id] = user.id
    end
    flash[:info] = "Welcome to ApIcUrIoUs #{current_user.name}"
    redirect_to user_path(current_user.username)
  end

  def destroy
    session.clear
    flash[:bye] = "Come back soon! 👋"
    redirect_to root_path
  end
end
