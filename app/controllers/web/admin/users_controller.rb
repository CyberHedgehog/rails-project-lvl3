# frozen_string_literal: true

class Web::Admin::UsersController < Web::Admin::ApplicationController
  before_action :authorize_admin

  def index
    @users = User.order(created_at: :desc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def edit
    @user = user
  end

  def update
    if user.update(user_params)
      redirect_to admin_users_path
    else
      render :edit, status: :unprocessible_entity
    end
  end

  def destroy
    user.destroy
    redirect_to admin_users_path
  end

  private

  def user
    @user ||= User.find(params[:id])
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :admin, :name)
  end

  def authorize_admin
    authorize %i[admin user]
  end
end
