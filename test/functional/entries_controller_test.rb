require 'test_helper'

class EntriesControllerTest < ActionController::TestCase
  fixtures :entries
  
  test "should get index with all entries" do
    get :index
    assert_response :success
    assert_equal assigns(:entries).size, 3
  end
  
  test "should get index only with entries by user 1" do
    get :index, { :user_id => 1 }
    assert_response :success
    assert_equal assigns(:entries).size, 1
  end
  
  test "should get show" do
    get :show, { :id => 1 }
    assert_response :success
    assert_equal assigns(:entry).id, 1
  end
end
