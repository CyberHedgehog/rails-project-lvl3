# frozen_string_literal: true

class Admin::AdminPolicy < ApplicationPolicy
  def index?
    admin?
  end

  def show?
    admin?
  end

  def new?
    admin?
  end

  def create?
    admin?
  end

  def edit?
    admin?
  end

  def update?
    admin?
  end

  def delete?
    admin?
  end

  private

  def admin?
    user.admin?
  end
end
