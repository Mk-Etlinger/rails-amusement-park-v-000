class AttractionsController < ApplicationController
  def index
    @attractions = Attraction.all
    @user = User.find(session[:user_id])
  end

  def show
    set_attraction
  end

  def new
    @attraction = Attraction.new
  end  
  
  def create
    @attraction = Attraction.create(attraction_params)
    redirect_to attraction_path(@attraction)
  end

  def edit
    set_attraction

  end

  def update
    set_attraction
    @attraction.update(attraction_params)
    redirect_to attraction_path(@attraction)
  end
  
  private

  def set_attraction
    @attraction = Attraction.find(params[:id])
  end  

  def attraction_params
    params.require(:attraction).permit(:name,
      :tickets, 
      :nausea_rating,
      :happiness_rating,
      :min_height)
  end
  
end
