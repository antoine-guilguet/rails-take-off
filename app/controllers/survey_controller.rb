class SurveyController < ApplicationController
  def create
    Survey.new
  end
end
