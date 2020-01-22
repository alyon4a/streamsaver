class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id 
      redirect_to user_dashboard_path
    else
      flash[:error] = "Login information incorrect. Please try again."
      redirect_to login_path
    end 
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end

end
