class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    redirect_to user_dashboard_path(@user)
  end

  def show
  end

  private 

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :phone_number)
  end 
end
