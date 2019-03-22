require 'test_helper'

class StatisticsControllerTest < ActionDispatch::IntegrationTest
  test "should get get" do
    get statistics_get_url
    assert_response :success
  end

end
