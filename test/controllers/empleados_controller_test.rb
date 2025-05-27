require "test_helper"

class EmpleadosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get empleados_index_url
    assert_response :success
  end

  test "should get new" do
    get empleados_new_url
    assert_response :success
  end

  test "should get create" do
    get empleados_create_url
    assert_response :success
  end

  test "should get edit" do
    get empleados_edit_url
    assert_response :success
  end

  test "should get update" do
    get empleados_update_url
    assert_response :success
  end

  test "should get destroy" do
    get empleados_destroy_url
    assert_response :success
  end
end
