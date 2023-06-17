require "test_helper"

class Public::SearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get result" do
    get public_searches_result_url
    assert_response :success
  end
end
