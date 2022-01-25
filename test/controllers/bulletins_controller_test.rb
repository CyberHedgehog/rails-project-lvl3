# frozen_string_literal: true

require 'test_helper'

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin = bulletins(:one)
    @user = users(:one)
  end

  test 'should get index' do
    get bulletins_path
    assert_response :success
  end

  test 'should get new' do
    sign_in @user
    get new_bulletin_path
    assert_response :success
  end

  test 'should get edit' do
    sign_in @user
    get edit_bulletin_path(@bulletin)
    assert_response :success
  end

  test 'should show' do
    get bulletin_path(@bulletin)
    assert_response :success
  end

  test 'should create' do
    sign_in @user
    category = categories(:one)
    title = Faker::Lorem.sentence
    post bulletins_path, params: { bulletin: {
      title: title,
      description: Faker::Lorem.paragraph,
      category_id: category.id
    } }
    new_bulletin = Bulletin.find_by(title: title)
    assert new_bulletin
    assert_redirected_to bulletin_path(new_bulletin)
  end

  test 'should update' do
    sign_in @user
    title = Faker::Lorem.sentence
    description = Faker::Lorem.paragraph
    put bulletin_path(@bulletin), params: { bulletin: {
      title: title,
      description: description,
      category_id: @bulletin.category.id
    } }
    bulletin = Bulletin.find(@bulletin.id)
    assert_redirected_to bulletin_path(@bulletin)
    assert bulletin.title, title
    assert bulletin.description, description
  end

  test 'should send to moderation' do
    sign_in @user
    bulletin = bulletins(:draft)
    patch to_moderate_bulletin_path(bulletin)
    moderated_bulletin = Bulletin.find(bulletin.id)
    assert moderated_bulletin.under_moderation?
  end

  test 'should archive' do
    sign_in @user
    bulletin = bulletins(:under_moderation)
    patch archive_bulletin_path(bulletin)
    archived_bulletin = Bulletin.find(bulletin.id)
    assert archived_bulletin.archived?
  end

  test 'should destroy' do
    sign_in @user
    delete bulletin_path(@bulletin)
    assert_not Bulletin.find_by(id: @bulletin.id)
  end

  test 'shold not create if unregistered' do
    title = Faker::Lorem.sentence
    category = categories(:one)
    post bulletins_path, params: { bulletin: {
      title: title,
      description: Faker::Lorem.paragraph,
      category_id: category.id
    } }
    new_bulletin = Bulletin.find_by(title: title)
    assert_not new_bulletin
  end
end
