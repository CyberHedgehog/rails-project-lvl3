# frozen_string_literal: true

class Web::ProfileController < Web::ApplicationController
  before_action :authenticate_user!
  def index
    # @bulletins = Bulletin.order(created_at: :desc).where(user_id: current_user.id).page params[:page]
    @bulletins = current_user.bulletins.order(created_at: :desc).page(params[:page])
  end
end
