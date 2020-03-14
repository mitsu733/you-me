require 'test_helper'

class LinkesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get linkes_index_url
    assert_response :success
  end

end
