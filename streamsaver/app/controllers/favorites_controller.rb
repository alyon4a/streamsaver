class FavoritesController < ApplicationController

  before_action :logged_in?

  def create
  end

  def index
  
    if current_user
      @favorites = current_user.favorites
    else 
      redirect_to login_path
    end 
  end

end
