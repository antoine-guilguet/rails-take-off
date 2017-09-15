class TopicsController < ApplicationController

  before_action :set_trip, only: [:new, :create]
  before_action :set_topic, only: [:edit, :update, :destroy, :confirm]

  def new
    @topic = Topic.new
    authorize @topic
  end

  def create
    @topic = Topic.new(topic_params)
    authorize @topic
    @topic.trip = @trip
    @topic.status = "Pending"
    if @topic.save
      redirect_to trip_path(@trip, anchor: "organization")
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @topic.update(topic_params)
      redirect_to trip_path(@topic.trip, anchor: "organization")
    else
      render :edit
    end
  end

  def destroy
    @topic.destroy
    redirect_to trip_path(@topic.trip, anchor: "organization")
  end

  def confirm
    @topic = Topic.find(params[:id])
    @suggestions = @topic.sort_suggestions_by_vote
    @suggestion = @topic.find_winning_suggestion
    # Lead to suggestions#update
  end

  def create_auto
    topic_type = params[:topic_type]
    @topic = Topic.create(title: topic_type, user_id: current_user.id, trip_id: @trip.id, status: "Pending")
    respond_to do |format|
      format.js
    end
  end

  def get_suggestion
    @topic = Topic.find(params[:id])
    authorize @topic
    @suggestion = Suggestion.find(params[:suggestion_id])
    respond_to do |format|
      format.js
    end
  end

  private

  def set_trip
    @trip = Trip.find(params[:trip_id])
  end

  def set_topic
    @topic = Topic.find(params[:id])
    authorize @topic
  end

  def topic_params
    params.require(:topic).permit(:title, :description)
  end
end
