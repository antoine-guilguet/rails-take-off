class SurveysController < ApplicationController
  before_action :find_survey, only:[:show]

  def show
    @trip = @survey.trip
    @survey_dates = @survey.survey_dates
  end

  private

  def find_survey
    @survey = Survey.find(params[:id])
  end
end