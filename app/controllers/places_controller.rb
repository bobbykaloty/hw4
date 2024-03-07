class PlacesController < ApplicationController

  def index
    @user = User.find_by(id: session["user_id"])
    if @user
      @places = @user.places
    else
      flash[:notice] = "User not found."
    end
  end

  def show
    @user = User.find_by(id: session["user_id"])
    if @user
      @place = @user.places.find_by(id: params[:id])
      if @place
        @entries = @place.entries
      else
        flash[:alert] = "Place not found."
      end
    else
      flash[:alert] = "User not found."
    end
  end

  def create
    @user = User.find_by({ "id" => session["user_id"] })
    if @user != nil
      @place = Place.new
      @place["name"] = params["name"]
      @place["user_id"] = session["user_id"]
      @place.save
    else
      flash["notice"] = "User not found."
    end
    redirect_to "/places"
  end

end
