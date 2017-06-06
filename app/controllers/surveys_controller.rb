class SurveysController < ApplicationController
  before_action :find_survey, only:[:show, :vote]

  def show
    @trip = @survey.trip
    @survey_dates = @survey.survey_dates
  end

  def vote
    @survey_date = SurveyDate.find(params[:survey_date_id])
    @survey_date.vote_by :voter => current_user
    respond_to do |format|
      format.html { redirect_to survey_path(@survey) }
      format.js { render "vote", :locals => {:survey_date_id => params[:survey_date_id]} }
    end

  end

  private

  def find_survey
    @survey = Survey.find(params[:id])
  end
end