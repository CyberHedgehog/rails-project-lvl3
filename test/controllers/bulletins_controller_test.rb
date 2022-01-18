# frozen_string_literal: true

require 'test_helper'

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin = bulletins(:one)
    @user = users(:one)
    @category = categories(:one)
    @title = Faker::Lorem.sentence
    @description = Faker::Lorem.paragraph
    sign_in @user
  end

  test 'should get index' do
    get bulletins_path
    assert_response :success
  end

  test 'should get new' do
    get new_bulletin_path
    assert_response :success
  end

  test 'should get edit' do
    get edit_bulletin_path(@bulletin)
    assert_response :success
  end

  test 'should show' do
    sign_out :user
    get bulletin_path(@bulletin)
    assert_response :success
  end

  test 'should create' do
    post bulletins_path, params: { bulletin: {
      title: @title,
      description: @description,
      category_id: @category.id
    } }
    new_bulletin = Bulletin.find_by(title: @title)
    assert new_bulletin
    assert_redirected_to bulletin_path(new_bulletin)
  end

  test 'should update' do
    put bulletin_path(@bulletin), params: { bulletin: {
      title: @title,
      description: @description,
      category_id: @bulletin.category.id
    } }
    bulletin = Bulletin.find(@bulletin.id)
    assert_redirected_to bulletin_path(@bulletin)
    assert bulletin.title, @title
    assert bulletin.description, @description
  end

  test 'should destroy' do
    delete bulletin_path(@bulletin)
    assert_not Bulletin.find_by(id: @bulletin.id)
  end

  test 'shold not create if unregistered' do
    sign_out :user
    post bulletins_path, params: { bulletin: {
      title: @title,
      description: @description,
      category_id: @category.id
    } }
    new_bulletin = Bulletin.find_by(title: @title)
    assert_not new_bulletin
    assert_redirected_to new_user_session_path
  end
end
