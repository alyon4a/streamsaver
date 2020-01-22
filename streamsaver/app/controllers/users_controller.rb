class UsersController < ApplicationController
  before_action :logged_in?, except: [:new]
  
  def new
    @user = User.new
  end

  def login 
    @user
  end 

  def create
    @user = User.new(user_params)
    if @user.valid? 
      @user.save
      session[:user_id] = @user.id 
      redirect_to user_dashboard_path(@user)
    else 
      flash[:errors] = @user.errors.full_messages
      redirect_to users_path
    end 
  end

  def index 
  end 

  def show
    @user = User.find(params[:id])
    if @user != current_user 
      redirect_to login_path 
    end 
  end

  private 

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :phone_number)
  end 
end
