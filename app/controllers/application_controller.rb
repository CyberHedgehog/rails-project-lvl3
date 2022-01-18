# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  include Auth

  helper_method :current_user
end
