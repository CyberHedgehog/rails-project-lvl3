# frozen_string_literal: true

module Auth
  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    session.delete(:user_id)
    session.clear
  end

  def current_user
    @current_user ||= session[:user_id] && User.find(session[:user_id])
  end

  def authenticate_user!
    current_user.present?
  end

  def admin_signed_in?
    current_user.admin?
  end

  def authenticate_admin!
    return if admin_signed_in?

    flash[:error] = t('forbidden')
    redirect_to root_path
  end
end
