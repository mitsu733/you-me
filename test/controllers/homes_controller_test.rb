require 'test_helper'

class HomesControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get homes_top_url
    assert_response :success
  end

  test "should get about_user" do
    get homes_about_user_url
    assert_response :success
  end

  test "should get about_record" do
    get homes_about_record_url
    assert_response :success
  end

end
