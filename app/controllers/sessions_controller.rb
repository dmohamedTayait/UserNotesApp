##
# Sessions Controller: Manege login/logout actions
#
class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to users_url
    end
    user = User.new
  end

  #Login - Create new session
  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      puts user.id
      redirect_to users_path
    else
      flash.now[:danger] = 'Authentication failed.Check your email or password and try again.'
      render 'new'
    end
  end

  #logout - Destroy user session
  def destroy
    session.delete(:user_id)
    redirect_to root_url
  end

end
