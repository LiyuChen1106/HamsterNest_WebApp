require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get welcome_show_url
    assert_response :success
  end

end
