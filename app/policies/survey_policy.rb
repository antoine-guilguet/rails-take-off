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

  def create?
    true
  end

  def destroy?
    record.trip.host == user
  end

  def show?
    true
  end

  def vote?
    true
  end

end
