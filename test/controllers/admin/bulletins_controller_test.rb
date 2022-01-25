# frozen_string_literal: true

require 'test_helper'

class Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin = bulletins(:one)
    @admin = users(:admin)
  end

  test 'should get index' do
    sign_in @admin
    get admin_bulletins_path
    assert_response :success
  end

  test 'should not get index if user is not admin' do
    user = users(:one)
    sign_in user
    get admin_bulletins_path
    assert_redirected_to root_path
  end

  test 'should show' do
    get bulletin_path(@bulletin)
    assert_response :success
  end

  test 'should publish' do
    sign_in @admin
    bulletin = bulletins(:under_moderation)
    patch publish_admin_bulletin_path(bulletin)
    published_bulletin = Bulletin.find(bulletin.id)
    assert published_bulletin.published?
  end

  test 'should reject' do
    sign_in @admin
    bulletin = bulletins(:under_moderation)
    patch reject_admin_bulletin_path(bulletin)
    rejected_bulletin = Bulletin.find(bulletin.id)
    assert rejected_bulletin.rejected?
  end

  test 'should archive' do
    sign_in @admin
    bulletin = bulletins(:under_moderation)
    patch archive_admin_bulletin_path(bulletin)
    archive_bulletin = Bulletin.find(bulletin.id)
    assert archive_bulletin.archived?
  end

  test 'should destroy' do
    sign_in @admin
    delete bulletin_path(@bulletin)
    assert_not Bulletin.find_by(id: @bulletin.id)
  end
end
