class SurveysController < ApplicationController
  before_action :find_survey, only:[:show, :vote]

  def show
    @trip = @survey.trip
    @survey_dates = @survey.survey_dates
  end

  def vote
    @survey_date = SurveyDate.find(params[:survey_date_id])
    @survey_date.vote_by :voter => current_user
    redirect_to survey_path(@survey)
  end

  private

  def find_survey
    @survey = Survey.find(params[:id])
  end
end