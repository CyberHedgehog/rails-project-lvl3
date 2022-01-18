# frozen_string_literal: true

class User < ApplicationRecord
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email || ''
      user.provider = auth.provider
      user.uid = auth.uid

      user.save!
    end
  end

  def admin?
    admin ? true : false
  end

  # validates :email, presence: true, uniqueness: true
end
