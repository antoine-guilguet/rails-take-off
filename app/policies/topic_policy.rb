class TopicPolicy < ApplicationPolicy

  def new?
    true
  end

  def create?
    true
  end

  def edit?
    record.user_id == user.id
  end

  def update?
    record.user_id == user.id
  end

  def destroy?
    record.user_id == user.id
  end

  def confirm?
    true
  end

  def get_suggestion?
    true
  end
end