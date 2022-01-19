# frozen_string_literal: true

module Auth
  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    @current_user = nil
    session.delete(:user_id)
    session.clear
  end

  def current_user
    @current_user ||= session[:user_id] && User.find(session[:user_id])
  end

  def authenticate_user!
    return if current_user.present?
    redirect_to root_path, alert: t('auth.not_authenticated')
  end

  def admin_signed_in?
    current_user.admin?
  end

  def authenticate_admin!
    return if admin_signed_in?

    redirect_to root_path, alert: t('auth.not_authrised')
  end
end
