# frozen_string_literal: true

class ProfileController < ApplicationController
  def index
    @bulletins = Bulletin.order(created_at: :desc).where(user_id: current_user.id).page params[:page]
  end
end
