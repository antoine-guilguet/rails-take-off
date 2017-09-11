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
    record.user_id == user.id
  end
end