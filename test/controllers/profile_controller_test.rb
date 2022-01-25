# frozen_string_literal: true

require 'test_helper'

class ProfileControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    user = users(:one)
    sign_in user
    get profile_path
    assert_response :success
  end

  test 'should not get index if unauthorised' do
    get profile_path
    assert_redirected_to root_path
  end
end
