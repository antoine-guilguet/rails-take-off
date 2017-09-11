class SuggestionPolicy < ApplicationPolicy

  def create?
    return true
  end

  def edit?
    return true
  end

  def vote?
    record.topic.trip.trip_participants.map{ |participant| participant.user.id }.include?(record.user_id)
  end

  def update?
    true
  end
end