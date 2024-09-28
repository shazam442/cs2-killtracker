require "test_helper"

class SteamUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get steam_users_show_url
    assert_response :success
  end
end
