class SurveyDate < ActiveRecord::Base
  belongs_to :survey

  acts_as_votable

  def to_date
    self
  end
end
