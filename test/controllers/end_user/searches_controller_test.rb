require "test_helper"

class EndUser::SearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get end_user_searches_search_url
    assert_response :success
  end
end
