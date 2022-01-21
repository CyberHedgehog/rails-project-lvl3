# frozen_string_literal: true

class User < ApplicationRecord
  def admin?
    admin ? true : false
  end

  has_many :bulletins, dependent: :destroy

  validates :email, presence: true, uniqueness: true
end
