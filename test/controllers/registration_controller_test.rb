require 'test_helper'

class RegistrationControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get register_new_url
    assert_response :success
  end

  test "should get create" do
    get register_create_url
    assert_response :success
  end

end
