# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  before_action :authorize_admin

  def index
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result(distinct: true).order(created_at: :desc).page params[:page]
  end

  private

  def authorize_admin
    authorize %i[admin bulletin]
  end
end
