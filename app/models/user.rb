# frozen_string_literal: true

class User < ApplicationRecord
  def admin?
    admin ? true : false
  end

  validates :email, presence: true, uniqueness: true
end
