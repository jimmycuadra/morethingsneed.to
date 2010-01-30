require 'test_helper'
require 'authlogic/test_case'

class EntriesControllerTest < ActionController::TestCase
  setup :activate_authlogic
  
  def setup
    Entry.create(:noun => 'pigs', :verb => 'squeak', :ip => generate_ip, :id => 1)
    Entry.create(:noun => 'dogs', :verb => 'bark', :ip => generate_ip, :id => 2)
    Entry.create(:noun => 'cats', :verb => 'meow', :ip => generate_ip, :user_id => 1, :id => 3)
    Entry.create(:noun => 'people', :verb => 'rule', :spam => true, :ip => generate_ip, :id => 4)
  end

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
  
  test "should show entry with no spam comments" do
    get :show, { :id => 1 }
    assert_response :success
    assert_equal assigns(:entry).id, 1
    assert_equal assigns(:comments).count, 3
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
    post :destroy, { :id => 1 }
    assert_redirected_to entries_path
    assert_not_nil flash[:success]
  end
  
  test "should redirect to index when accessing show_spam if not admin" do
    get :show_spam
    assert_redirected_to entries_path
  end

  test "should get all entries including spam if admin" do
    UserSession.create(users(:dodongo))
    get :show_spam
    assert_response :success
    assert_equal assigns(:entries).size, 4
  end
  
  test "should redirect to root without toggling spam if not admin" do
    put :toggle_spam, :id => 1
    assert_redirected_to root_path
  end
  
  test "should redirect to entry after toggling spam if admin" do
    UserSession.create(users(:dodongo))
    put :toggle_spam, :id => 1
    assert_redirected_to entry_path(assigns(:entry))
  end
  
  test "should show entry with spam comments if admin" do
    UserSession.create(users(:dodongo))
    get :show, { :id => 1, :show_spam => 1 }
    assert_response :success
    assert_equal assigns(:entry).id, 1
    assert_equal assigns(:comments).count, 4
  end
end
