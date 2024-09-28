require "test_helper"

class GameStateEventsControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get game_state_events_home_url
    assert_response :success
  end
end
