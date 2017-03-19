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
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def trip_params
    params.require(:trip).permit(:name, :destination)
  end

  def find_user_trips
    trip_participants = TripParticipant.where(trip_id: current_user.id)
    user_trips = []
    trip_participants.each do |trip_participant|
      user_trips << trip_participant.trip
    end
    user_trips
  end
end
