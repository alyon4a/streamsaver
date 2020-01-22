class ShowsController < ApplicationController
  before_action :logged_in?

  def new
    @show = Show.new
    @providers = Provider.all
  end

  def create
    @show = Show.create(show_params)
    
    #handle errors
    
    redirect_to shows_path
  end

  def index
      @shows_by_provider = Show.all_shows_by_provider
  end

  private 
  
  def show_params
    params.require(:show).permit(:name, :description, :image_url, :provider_id)
  end
end
