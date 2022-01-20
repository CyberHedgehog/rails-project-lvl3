# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  before_action :authorize_admin

  def index
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result(distinct: true).order(created_at: :desc).page params[:page]
  end

  def publish
    @bulletin.moderate!
    redirect_to admin_bulletins_path
  end

  def archive
    @bulletin.archive!
    redirect_to request.referer
  end

  def approve
    @bulletin.approve!
    redirect_to request.referer
  end

  def reject
    @bulletin.reject!
    redirect_to request.referer
  end

  private

  def authorize_admin
    authorize %i[admin bulletin]
  end
end
