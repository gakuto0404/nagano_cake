require "test_helper"

class Admin::OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get admin_orders_edit_url
    assert_response :success
  end
end
