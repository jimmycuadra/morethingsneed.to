require File.dirname(__FILE__) + '/../test_helper'

class UsersControllerTest < ActionController::TestCase     
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end
end