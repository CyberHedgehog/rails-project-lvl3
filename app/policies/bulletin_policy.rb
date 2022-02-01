# frozen_string_literal: true

class BulletinPolicy < Admin::AdminPolicy
  def new?
    user.present?
  end

  def edit?
    owner?
  end

  def create?
    user.present?
  end

  def update?
    owner?
  end

  def destroy?
    owner? || admin?
  end

  def to_moderate?
    owner?
  end

  def archive?
    owner? || admin?
  end

  def publish?
    admin?
  end

  def reject?
    admin?
  end

  private

  def owner?
    record.user == user
  end

  def admin?
    user&.admin?
  end
end
