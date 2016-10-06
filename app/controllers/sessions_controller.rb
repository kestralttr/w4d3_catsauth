class SessionsController < ApplicationController

  before_action :logged_in?, only: [:destroy]

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    user.reset_session_token!
    session[:session_token] = user.session_token
    redirect_to cats_url

  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to cats_url
  end

  private

  def session_params
    params.require(:user).permit(:username, :password)
  end

end
