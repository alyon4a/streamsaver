class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def login 
  end 

  def create
    @user = User.new(user_params)
    if @user.valid? 
      @user.save
      redirect_to user_dashboard_path(@user)
    else 
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_path
    end 
  end

  def show
    @user = User.find(params[:id])
  end

  private 

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :phone_number)
  end 
end
