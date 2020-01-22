class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id 
    end 
  end

  #Needs to be tested/implemented
  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end

end
