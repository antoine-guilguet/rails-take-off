class SurveyDate < ActiveRecord::Base
  belongs_to :survey

  acts_as_votable
end
