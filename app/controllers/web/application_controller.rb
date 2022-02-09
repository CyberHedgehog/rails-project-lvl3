# frozen_string_literal: true

class Web::ApplicationController < ApplicationController
  include Pundit
  include Auth

  helper_method :current_user

  rescue_from Pundit::NotAuthorizedError, with: :redirect_unauthorized_user

  private

  def redirect_unauthorized_user
    flash.alert = t 'users.not_authorized'
    redirect_to request.referer || root_path
  end
end
