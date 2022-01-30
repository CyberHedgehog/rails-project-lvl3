# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  before_action :authorize_admin

  def index
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result(distinct: true).order(created_at: :desc).page params[:page]
  end

  def to_moderate
    bulletin.moderate!
    redirect_to admin_bulletins_path
  end

  def publish
    bulletin.publish!
    redirect_to admin_bulletins_path
  end

  def archive
    bulletin.archive!
    redirect_to admin_bulletins_path
  end

  def reject
    bulletin.reject!
    redirect_to admin_bulletins_path
  end

  private

  def bulletin
    @bulletin ||= Bulletin.find(params[:id])
  end

  def authorize_admin
    authorize %i[admin bulletin]
  end
end
