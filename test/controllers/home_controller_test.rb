require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get secret" do
    get home_secret_url
    assert_response :success
  end

end
