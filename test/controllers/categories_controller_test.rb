# frozen_string_literal: true

require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @category = categories(:one)
    @name = Faker::Lorem.word
    sign_in @admin
  end

  test 'should get index' do
    get admin_categories_path
    assert_response :success
  end

  test 'should not get index if unauthorized' do
    sign_out @admin
    sign_in users(:one)
    get admin_categories_path
    assert_redirected_to root_path
  end

  test 'should get new' do
    get new_admin_category_path
    assert_response :success
  end

  test 'should create' do
    post admin_categories_path, params: { category: { name: @name } }
    new_category = Category.find_by(name: @name)
    assert new_category
    assert_redirected_to admin_categories_path
  end

  test 'should get edit' do
    get edit_admin_category_path(@category)
    assert_response :success
  end

  test 'Should update' do
    new_name = Faker::Lorem.word
    put admin_category_path(@category), params: { category: { name: new_name } }
    category = Category.find(@category.id)
    assert_redirected_to admin_categories_path
    assert category.name, new_name
  end

  test 'Should destroy' do
    delete admin_category_path(@category)
    assert_not Category.find_by(id: @category.id)
  end
end
