class TripsController < ApplicationController
  before_action :find_trip, only:[:show, :edit, :update, :destroy, :leave]

  def index
    @trips = current_user.trips.where.not(user_id: current_user.id)
    @mytrips = policy_scope(Trip)
    @invitations = Invite.where(email: current_user.email, confirmed: false)
  end

  def new
    @trip = Trip.new
    authorize @trip
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.host = current_user
    authorize @trip
    if params[:trip][:start_date].count > 1 && @trip.save
      @survey = Survey.create
      start_dates = params[:trip][:start_date]
      end_dates = params[:trip][:end_date]
      start_dates.each_with_index do |date, index|
        SurveyDate.create(start_date: start_dates[index], end_date: end_dates[index], survey_id: @survey.id)
      end
      @survey.trip_id = @trip.id
      @survey.save
      TripParticipant.create(user_id: current_user.id, trip_id: @trip.id)
      redirect_to trips_path
    elsif @trip.save
      TripParticipant.create(user_id: current_user.id, trip_id: @trip.id)
      @trip.start_date = params[:trip][:start_date][0]
      @trip.end_date = params[:trip][:end_date][0]
      @trip.save
      redirect_to trips_path
    else
      render :new
    end
  end

  def show
    authorize @trip
    if @trip.survey
      @survey = @trip.survey
      @survey_dates = @survey.survey_dates.sort_by { |survey_date| survey_date.votes_for.size }.reverse!
    end
    @trips = [@trip]
    @hash = Gmaps4rails.build_markers(@trips) do |trip, marker|
      marker.lat trip.latitude
      marker.lng trip.longitude
      # marker.infowindow render_to_string(partial: "/flats/map_box", locals: { flat: flat })
    end
  end

  def edit
    authorize @trip
  end

  def update
    authorize @trip
    if @trip.update(trip_params) && params[:trip][:start_date].count > 1
      @survey = Survey.create
      start_dates = params[:trip][:start_date]
      end_dates = params[:trip][:end_date]
      start_dates.each_with_index do |date, index|
        SurveyDate.create(start_date: start_dates[index], end_date: end_dates[index], survey_id: @survey.id)
      end
      @survey.trip_id = @trip.id
      @survey.save
      redirect_to trips_path
    elsif @trip.update(trip_params)
      @trip.start_date = params[:trip][:start_date][0]
      @trip.end_date = params[:trip][:end_date][0]
      @trip.save
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
    if @trip.host == current_user
      @trip.host = TripParticipant.where(trip_id: @trip.id).first.user
      @trip.save
    end
    redirect_to trips_path
  end

  private

  def trip_params
    params.require(:trip).permit(:name, :destination, :start_date, :end_date)
  end

  def find_trip
    @trip = Trip.find(params[:id])
    authorize @trip
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
