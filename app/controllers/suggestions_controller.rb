class SuggestionsController < ApplicationController
  before_action :find_topic

  def new
    @suggestion = Suggestion.new
  end

  def create
    @suggestion = Suggestion.new(set_suggestion)
    @suggestion.topic = @topic
    @suggestion.user = current_user
    if @suggestion.save
      redirect_to trip_path(@topic.trip)
    else
      render :new
    end
  end

  private

  def find_topic
    @topic = Topic.find(params[:topic_id])
    authorize @topic
  end

  def set_suggestion
    params.require(:suggestion).permit(:name, :description, :price)
  end
end
