require "test_helper"

class PerfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get perfiles_edit_url
    assert_response :success
  end

  test "should get update" do
    get perfiles_update_url
    assert_response :success
  end
end
