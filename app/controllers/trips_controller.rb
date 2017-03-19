class TripsController < ApplicationController

  def index
    @trips = find_user_trips
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      redirect_to trip_path
    else
      render :new
    end
  end

  private
  def trip_params
    params.require(:trip).permit(:name, :destination)
  end
  
end
