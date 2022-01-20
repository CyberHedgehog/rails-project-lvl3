# frozen_string_literal: true

class Web::ApplicationController < ApplicationController
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash.alert = t 'users.not_authorized'
    redirect_to request.referer || root_path
  end
end
