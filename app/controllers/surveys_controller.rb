class SurveysController < ApplicationController
  before_action :find_survey, only:[:show, :vote]

  def show
    @trip = @survey.trip
    @survey_dates = @survey.survey_dates
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

  private

  def find_survey
    @survey = Survey.find(params[:id])
  end

  def un
    respond_to do |format|
      format.html { redirect_to survey_path(@survey) }
      format.js { render "vote", :locals => {:survey_date_id => params[:survey_date_id]} }
    end
  end
end