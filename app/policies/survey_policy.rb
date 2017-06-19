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
    raise
  end

  def set_deadline?
    record.trip.host == user
  end
end
