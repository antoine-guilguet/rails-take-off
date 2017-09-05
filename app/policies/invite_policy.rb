class InvitePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def new?
    return true
  end

  def create?
    return true
  end

  def decline?
    record.recipient_id == User.find_by(email: record.email).id
  end

  def confirm?
    record.recipient_id == User.find_by(email: record.email).id
  end
end
