class TopicsController < ApplicationController
  before_action :set_trip, except: [:vote]
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

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

  def vote
    @suggestion = Suggestion.find(params[:suggestion_id])
    if current_user.voted_up_on? @suggestion
      # Downvote Suggestion
      @suggestion.unliked_by current_user
      render json: {
          suggestion: @suggestion,
          number_of_votes: @suggestion.votes_for.size,
          html_list_of_voters: @suggestion.get_html_list_of_voters,
          message: "downvote"
      }
    else
      # Vote for suggestion
      @suggestion.liked_by current_user
      render json: {
          suggestion: @suggestion,
          number_of_votes: @suggestion.votes_for.size,
          html_list_of_voters: @suggestion.get_html_list_of_voters,
          message: "vote"
      }
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
