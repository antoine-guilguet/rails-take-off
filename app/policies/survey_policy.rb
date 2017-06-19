class SurveyPolicy < ApplicationPolicy

  class Scope < Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end

  def destroy?
    record.trip.host == user
  end

  def set_deadline?
    record.trip.host == user
  end

  def set_deadline?
    record.trip.host == user
  end
end
