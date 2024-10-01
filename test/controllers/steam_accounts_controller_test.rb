require "test_helper"

class SteamAccountsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get steam_accounts_show_url
    assert_response :success
  end
end
