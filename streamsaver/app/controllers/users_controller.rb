class UsersController < ApplicationController
  before_action :logged_in?, except: [:new, :create]
  
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
    @user = current_user
    @current_month = session[:month] ? session[:month] : Favorite.number_to_month(Time.now.month)
    @current_day = session[:day] ? session[:day] : Time.now.day
    @current_month_number = session[:month_number] ? session[:month_number] : Time.now.month
    @favorites_this_month = @user.display_favorites(@current_month, true)
    @upcoming_favorites = @user.display_favorites(@current_month, false)
    @reminders = @user.get_reminders(@current_month_number, @current_day)
    if @reminders.empty? 
      @reminders <<"Welcome, #{@user.first_name}! You have no messages."
    end 
  end

  def set_date
    user = current_user
    session[:day] = params[:date]["date(3i)"]
    
    month_number = params[:date]["date(2i)"].to_i
    session[:month_number] = month_number
    session[:month] = Favorite.all_months[month_number - 1]
    reminders = user.get_reminders(session[:month_number], session[:day])
    if !reminders.empty?
        UserMailer.notification_email(user, reminders).deliver_now
    end 
    redirect_to user_dashboard_path
  end

  private 

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :phone_number)
  end 
end
