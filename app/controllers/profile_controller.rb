# frozen_string_literal: true

class ProfileController < ApplicationController
  def index
    @bulletins = Bulletin.where(user_id: current_user.id)
  end
end
