require 'test_helper'

class AboutControllerTest < ActionDispatch::IntegrationTest
  test "should get creator" do
    get about_creator_url
    assert_response :success
  end

  test "should get assignments" do
    get about_assignments_url
    assert_response :success
  end

end
