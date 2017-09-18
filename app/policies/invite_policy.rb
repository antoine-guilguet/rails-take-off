class InvitePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def new?
    true
  end

  def create?
    true
  end

  def decline?
    record.email == user.email
  end

  def confirm?
    record.email == user.email
  end

end
