require 'test_helper'

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get signup" do
    get api_v1_users_signup_url
    assert_response :success
  end

end
