class TripPolicy < ApplicationPolicy

  class Scope < Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      scope.where(user_id: @user)
    end
  end

  def create?
    return true
  end

  def show?
    record.trip_participants.map(&:user_id).include?(user.id)
  end

  def edit?
    record.host == user
  end

  def update?
    record.host == user
  end

  def destroy?
    record.host == user
  end

  def leave?
    record.trip_participants.map(&:user_id).include?(user.id)
  end

  def invite?
    record.host == user
  end

  def create_auto?
    return true
  end
end
