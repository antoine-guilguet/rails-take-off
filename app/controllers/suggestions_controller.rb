class SuggestionsController < ApplicationController

  before_action :find_topic, except: [:vote]
  before_action :find_suggestion, only: [:update]

  def new
    @suggestion = Suggestion.new
    authorize @suggestion
  end

  def create
    @suggestion = Suggestion.new(set_suggestion)
    authorize @suggestion
    @suggestion.topic = @topic
    @suggestion.user = current_user
    if @suggestion.save
      redirect_to trip_path(@topic.trip, anchor: "organization")
    else
      render :new
    end
  end

  def edit
  end

  def update
    if params[:suggestion][:confirmation] == "true"
      if @suggestion.update(set_suggestion)
        validate_suggestion_topic
        redirect_to trip_path(@suggestion.topic.trip, anchor: "organization")
      else
        render 'topics/confirm'
      end
    else
      if @suggestion.update(set_suggestion)
        redirect_to trip_path(@suggestion.topic.trip, anchor: "organization")
      else
        render "suggestions/edit"
      end
    end


  end

  def vote
    @suggestion = Suggestion.find(params[:suggestion_id])
    authorize @suggestion
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

  def find_topic
    @topic = Topic.find(params[:topic_id])
  end

  def find_suggestion
    @suggestion = Suggestion.find(params[:id])
    authorize @suggestion
  end

  def set_suggestion
    params.require(:suggestion).permit(:name, :description, :price)
  end

  def validate_suggestion_topic
    @topic = @suggestion.topic
    @topic.user_id = current_user.id
    @topic.status = "Closed"
    @topic.expense = @suggestion.price
    @topic.suggestion = @suggestion
    @topic.save
    Expense.create(amount: @suggestion.price, user_id: current_user.id, trip_id: @topic.trip.id, topic_id: @topic)
  end
end
