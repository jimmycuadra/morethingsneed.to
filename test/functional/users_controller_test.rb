require File.dirname(__FILE__) + '/../test_helper'

class UsersControllerTest < ActionController::TestCase     
  test "should get index" do
    get :index
    assert_response :success
    assert_equal assigns(:users).size, 2
  end
end
