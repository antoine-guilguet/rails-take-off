class TripsController < ApplicationController
  before_action :find_trip, only:[:show, :edit, :update, :destroy, :leave]


  def index
    @trips = find_user_trips
    @invitations = Invite.where(recipient_id: current_user.id, confirmed: false)
  end

  def new
    @trip = Trip.new
  end

  def create
    raise
    @trip = Trip.new(trip_params)
    if @trip.save
      TripParticipant.create(user_id: current_user.id, trip_id: @trip.id)
      redirect_to trips_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @trip.update(trip_params)
      redirect_to trips_path
    else
      render :edit
    end
  end

  def destroy
    @trip.destroy
    respond_to do |format|
      format.html { redirect_to trips_path }
      format.js
    end
  end

  def leave
    TripParticipant.find_by(user_id: current_user.id, trip_id: @trip.id).destroy
    redirect_to trips_path
  end

  private

  def trip_params
    params.require(:trip).permit(:name, :destination)
  end

  def find_trip
    @trip = Trip.find(params[:id])
  end

  def find_user_trips
    trip_participants = TripParticipant.where(user_id: current_user.id)
    user_trips = []
    trip_participants.each do |trip_participant|
      user_trips << trip_participant.trip
    end
    user_trips
  end
end
