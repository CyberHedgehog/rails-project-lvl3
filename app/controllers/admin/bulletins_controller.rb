# frozen_string_literal: true

class Admin::BulletinsController < Admin::ApplicationController
  before_action :authorize_admin

  def index
    @bulletins = Bulletin.order(created_at: :desc)
  end

  private

  def authorize_admin
    authorize %i[admin bulletin]
  end
end
