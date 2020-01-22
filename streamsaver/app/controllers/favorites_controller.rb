class FavoritesController < ApplicationController

  before_action :logged_in?

  def create
    user = User.first
    new_favorites = []
    show_ids = params[:user][:show_ids]
    show_ids.each do |show_id|
      if show_id != ""
        new_favorites << Favorite.create(user_id: user.id, show_id: show_id)
      end
    end

    @favorites = new_favorites
    @all_months = Favorite.all_months

    render 'plan'
  end

  def index
  
    if current_user
      @favorites = current_user.favorites
    else 
      redirect_to login_path
    end 
  end

  def create_plan
    puts params
    # parse fav_months and add them to months for each favorite

    redirect_to user_dashboard_path(User.first)
  end

end
