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
    authorize @trip
    @trip.host = current_user

    if params[:trip][:start_date].count > 1 && @trip.save
      @survey = Survey.create
      authorize @survey
      start_dates = params[:trip][:start_date]
      end_dates = params[:trip][:end_date]
      start_dates.each_with_index do |date, index|
        SurveyDate.create(start_date: start_dates[index], end_date: end_dates[index], survey_id: @survey.id)
      end
      @survey.trip_id = @trip.id
      @survey.save
      TripParticipant.create(user_id: current_user.id, trip_id: @trip.id)
      create_topics(@trip)
      redirect_to trip_path(@trip)
    elsif @trip.save
      TripParticipant.create(user_id: current_user.id, trip_id: @trip.id)
      @trip.start_date = params[:trip][:start_date][0]
      @trip.end_date = params[:trip][:end_date][0]
      @trip.save
      create_topics(@trip)
      redirect_to trip_path(@trip)
    else
      render :new
    end
  end

  def show
    @invite = Invite.new
    if @trip.survey
      @survey = @trip.survey
      @survey_dates = @survey.sort_by_votes
    end

    @topic = Topic.new
    @pending_topics = @trip.topics.where(status: "Pending")
    @closed_topics = @trip.topics.where(status: "Closed")

    @trips = [@trip]
    @hash = Gmaps4rails.build_markers(@trips) do |trip, marker|
      marker.lat trip.latitude
      marker.lng trip.longitude
    end

    @total = @trip.compute_total_expenses
    @participants = @trip.trip_participants.map{ |participant| participant.user }
    @expenses = compute_debts(@participants, @trip, @total)
  end

  def edit
    authorize @trip
  end

  def update
    authorize @trip
    if @trip.update(trip_params) && params[:trip][:start_date] && params[:trip][:start_date].count > 1
      @survey = Survey.create
      start_dates = params[:trip][:start_date]
      end_dates = params[:trip][:end_date]
      start_dates.each_with_index do |date, index|
        SurveyDate.create(start_date: start_dates[index], end_date: end_dates[index], survey_id: @survey.id)
      end
      @survey.trip_id = @trip.id
      @survey.save
      redirect_to trip_path(@trip)
    elsif @trip.update(trip_params) && params[:trip][:start_date]
      @trip.start_date = params[:trip][:start_date][0]
      @trip.end_date = params[:trip][:end_date][0]
      @trip.save
      redirect_to trip_path(@trip)
    elsif @trip.update(trip_params)
      redirect_to trip_path(@trip)
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

  def create_topics(trip)
    authorize trip
    Topic.create(title: "Housing", status: "Pending", user_id: trip.host.id, trip_id: trip.id)
    Topic.create(title: "Transport", status: "Pending", user_id: trip.host.id, trip_id: trip.id)
  end

  def compute_debts(users, t, total)
    # User and balance
    hash_debt = {}
    # User owes balance to another User
    hash_result = {}

    users.each do |user|
      hash_debt[user] = user.compute_user_balance(t, total)
    end

    hash_positive = hash_debt.select { |k, v| v >= 0 }.sort_by { |key, value| - value }.to_h
    hash_debt = hash_debt.select { |k, v| v < 0 }.sort_by { |key, value| value }.to_h


    hash_debt.each do |ower, balance|
      debt = balance.abs

      until debt < 0.1

        hash_result[ower] = []
        hash_positive.each do |receiver, value|
          if debt > value
            debt -= value
            hash_positive[receiver] = 0
            hash_result[ower] << [receiver, value]
          else
            hash_positive[receiver] -= debt
            hash_result[ower] << [receiver, debt]
            debt = 0
          end

        end

      end
    end
    return hash_result
  end

end
