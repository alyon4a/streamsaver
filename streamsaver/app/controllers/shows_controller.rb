class ShowsController < ApplicationController
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
    @shows = Show.all
  end

  private 
  
  def show_params
    params.require(:show).permit(:name, :description, :image_url, :provider)
  end
end
