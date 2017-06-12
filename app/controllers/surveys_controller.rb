class SurveysController < ApplicationController
  before_action :find_survey, only:[:show, :vote, :destroy]

  def show
    @trip = @survey.trip
    @survey_dates = @survey.survey_dates.sort_by { |survey_date| survey_date.votes_for.size }.reverse!
  end

  def destroy
    @trip = @survey.trip
    @survey_date = @survey.survey_dates.sort_by { |survey_date| survey_date.votes_for.size }.reverse!.first
    @trip.start_date = @survey_date.start_date
    @trip.end_date = @survey_date.end_date
    @trip.save
    @survey.destroy
    redirect_to trips_path
  end

  def vote
    @survey_date = SurveyDate.find(params[:survey_date_id])
    if current_user.voted_up_on? @survey_date
      # Downvote Survey Date
      @survey_date.unliked_by current_user
      render json: {
          survey_date: @survey_date,
          number_of_votes: @survey_date.votes_for.size,
          message: "downvote"
      }
    else
      # Vote for survey date
      @survey_date.liked_by current_user
      render json: {
          survey_date: @survey_date,
          number_of_votes: @survey_date.votes_for.size,
          message: "vote"
      }
    end
  end

  # to be re-worked with ajax request to update list voters in real time
  def get_voters
    @survey_date = SurveyDate.find(params[:survey_date_id])
    render json: {
        survey_date_id: @survey_date.id,
        html_list_of_voters: @survey_date.get_html_list_of_voters,
        message: "GOOD"
    }
  end

  private

  def find_survey
    @survey = Survey.find(params[:id])
  end
end