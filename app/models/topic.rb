class Topic < ActiveRecord::Base
  belongs_to :trip
  has_many :suggestions, dependent: :destroy
  has_one :suggestion, dependent: :destroy

  def sort_suggestions_by_vote
    self.suggestions.sort_by { |suggestion| suggestion.votes_for.size }.reverse!
  end

  def find_winning_suggestion
    self.suggestions.sort_by { |suggestion| suggestion.votes_for.size }.reverse.first
  end

end