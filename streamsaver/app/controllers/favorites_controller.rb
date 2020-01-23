class FavoritesController < ApplicationController

  #before_action :logged_in?

  def new 
    user = current_user
    shows = Show.all.select {|show| !user.shows.include?(show)}

    @shows_by_provider = Show.shows_by_provider(shows)
  end
  
  def create
    new_favorites = []
    
    show_params.each do |show_id|
        new_favorites << Favorite.create(user_id: current_user.id, show_id: show_id)
    end

    @favorites = new_favorites
    @all_months = Favorite.all_months

    render 'plan'
  end

  def index
    # if current_user
    #   @favorites = current_user.favorites
    #   @shows_by_provider = Show.all_shows_by_provider
    # else 
    #   redirect_to login_path
    # end 
  end

  def create_plan
    Favorite.parse_months(params[:fav_months])
    redirect_to user_dashboard_path
  end

  private

  def show_params
    params.keys.reduce([]) do |memo, param|
      if param.start_with?('show')
        memo << params[param].to_i
      end
      memo
    end
  end

end
