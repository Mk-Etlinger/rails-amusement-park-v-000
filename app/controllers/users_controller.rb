class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    session[:user_id] = @user.id
    redirect_to user_path(@user)
  end  

  def show
    set_user
    if logged_in?
      render :show
    else
      redirect_to root_path
    end
  
  end

  def update
    @user = User.find(session[:user_id])
    @attraction = Attraction.find(params[:id])
    @attraction.rides.build(user_id: @user.id)
    case ride_message =  @attraction.rides.last.take_ride
    when ride_message == true
      redirect_to user_path(@user), notice: "Thanks for riding the #{@attraction.name}!"
    else
      redirect_to user_path(@user), alert: ride_message
    end
    
  end  

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end  

  def user_params
    params.require(:user).permit(:name, :password, :happiness, :nausea, :tickets, :height, :admin)
  end

   def logged_in? 
    session[:user_id].present?
  end
  
end
