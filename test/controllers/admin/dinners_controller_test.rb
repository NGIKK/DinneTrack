require "test_helper"

class Admin::DinnersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_dinners_show_url
    assert_response :success
  end
end
