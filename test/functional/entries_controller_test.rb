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
  
  test "should save and display entry" do
    assert_difference('Entry.count') do
      post :create, :entry => { :noun => 'tests', :verb => 'to be written' }
    end
    assert_redirected_to entry_path(assigns(:new_entry))
    assert_not_nil flash[:success]
  end
  
  test "should reject invaild entry and render index" do
    post :create
    assert_template :index
    assert_not_nil flash[:error]
    assert assigns(:entries)
  end
  
  test "should destroy entry and redirect to index with message" do
    post :destroy, :id => 1
    assert_redirected_to entries_path
    assert_not_nil flash[:success]
  end
end
