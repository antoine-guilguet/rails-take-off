class AddSuggestionIdToTopic < ActiveRecord::Migration
  def change
    add_reference :topics, :suggestion, index: true, foreign_key: true
  end
end
