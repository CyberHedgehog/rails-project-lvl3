# frozen_string_literal: true

class Admin::BulletinsController < Admin::ApplicationController
  def index
    @bulletins = Bulletin.order(created_at: :desc)
  end
end
