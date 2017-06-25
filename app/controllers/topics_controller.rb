class TopicsController < ApplicationController
  before_action :set_trip

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.trip = @trip
    if @topic.save
      redirect_to trip_path(@trip)
    else
      render :new
    end
  end

  private

  def set_trip
    @trip = Trip.find(params[:trip_id])
    authorize @trip
  end

  def topic_params
    params.require(:topic).permit(:title, :description)
  end
end
