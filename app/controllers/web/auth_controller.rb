# frozen_string_literal: true

class Web::AuthController < Web::ApplicationController
  skip_before_action :verify_authenticity_token

  def callback
    user = User.from_omniauth(auth_hash)
    sign_in(user)

    redirect_to root_path, notice: t('sessions.welcome', user: user.email)
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
