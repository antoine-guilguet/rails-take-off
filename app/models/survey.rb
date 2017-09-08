class Survey < ActiveRecord::Base
  belongs_to :trip
  has_many :survey_dates, dependent: :destroy

  def sort_by_votes
    self.survey_dates.sort_by { |survey_date| survey_date.votes_for.size }.reverse!
  end

end
