class SurveysController < ApplicationController
  before_action :find_survey, only:[:show, :vote]

  def show
    @trip = @survey.trip
    @survey_dates = @survey.survey_dates
  end

  def vote
    respond_to do |format|
      format.html { redirect_to vote_survey_path(@survey)}
      format.js
    end
  end

  private

  def find_survey
    @survey = Survey.find(params[:id])
  end
end