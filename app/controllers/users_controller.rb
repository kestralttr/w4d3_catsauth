class UsersController < ApplicationController

  before_action :logged_in?

  def new
    render :new
  end

  def create
    user = User.new(user_params)
    if user.valid?
      user.save!
      session[:session_token] = user.session_token
      redirect_to cats_url
    else
      flash.now[:errors] = user.errors.full_messages
      redirect_to new_user_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :session_token)
  end
end
