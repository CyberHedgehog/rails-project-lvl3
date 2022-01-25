# frozen_string_literal: true

require 'test_helper'

class Admin::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @user = users(:one)
    @email = Faker::Internet.email
    sign_in @admin
  end

  test 'should get index' do
    get admin_users_path
    assert_response :success
  end

  test 'should not get index if unauthorized' do
    sign_out
    sign_in @user
    get admin_users_path
    assert_redirected_to root_path
  end

  test 'should get edit' do
    get edit_admin_user_path(@user)
    assert_response :success
  end

  test 'Should update' do
    put admin_user_path(@user), params: { user: { email: @email } }
    user = User.find(@user.id)
    assert_redirected_to admin_users_path
    assert user.email, @email
  end

  test 'Should destroy' do
    delete admin_user_path(@user)
    assert_not User.find_by(id: @user.id)
  end
end
