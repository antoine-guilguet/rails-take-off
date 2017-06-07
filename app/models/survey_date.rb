class SurveyDate < ActiveRecord::Base
  belongs_to :survey

  acts_as_votable

  def voted_by?(user)
    user.voted_for? self
  end
end
