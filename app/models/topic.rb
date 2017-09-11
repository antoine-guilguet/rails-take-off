class Topic < ActiveRecord::Base
  belongs_to :trip
  has_many :suggestions, dependent: :destroy
  has_one :expense

  def find_winning_suggestion
    self.suggestions.sort_by { |suggestion| suggestion.votes_for.size }
  end

end