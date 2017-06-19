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
    return true
  end

  def decline?
    return true
  end

  def confirm?
    return true
  end
end
