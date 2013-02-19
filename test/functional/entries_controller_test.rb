require 'test_helper'
require 'authlogic/test_case'

class EntriesControllerTest < ActionController::TestCase
  setup :activate_authlogic

  def setup
    Entry.create(noun: 'pigs', verb: 'squeak').tap { |e| e.ip = generate_ip }
    Entry.create(noun: 'dogs', verb: 'bark').tap { |e| e.ip = generate_ip }
    Entry.create(noun: 'cats', verb: 'meow').tap { |e| e.ip = generate_ip }
    Entry.create(noun: 'people', verb: 'rule').tap do |e|
      e.ip = generate_ip
      e.spam = true
    end
  end

  test "should get index with all entries" do
    get :index
    assert_response :success
    assert_equal assigns(:entries).size, 4
  end

  test "should get index only with entries by user 1" do
    get :index, { :user_id => 1 }
    assert_response :success
    assert_equal assigns(:entries).size, 1
  end

  test "should get index only with entries matching search query" do
    get :index, { :search => 'pigs' }
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
    assert_equal assigns(:entries).size, 5
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

  test "should get edit entry page" do
    @request.remote_addr = '1.2.3.4'
    get :edit, { :id => 1 }
    assert_response :success
  end

  test "should not get edit page if IP doesn't match record" do
    @request.remote_addr = '4.3.2.1'
    get :edit, { :id => 1 }
    assert_redirected_to root_path
    assert_not_nil flash[:error]
  end

  test "should not get edit page if longer than 5 minutes since record creation" do
    @request.remote_addr = '5.6.7.8'
    get :edit, { :id => 5 }
    assert_redirected_to root_path
    assert_not_nil flash[:error]
  end

  test "should update and redirect to entry" do
    @request.remote_addr = '1.2.3.4'
    put :update, { :id => 1, :entry => { :verb => 'be fuzzy' } }
    assert_template :show
    assert_not_nil flash[:success]
  end

  test "should not update entry and should render edit view if invalid update" do
    @request.remote_addr = '1.2.3.4'
    put :update, { :id => 1, :entry => { :noun => 'nouns', :verb => 'verb' } }
    assert_template :edit
    assert_not_nil flash[:error]
  end

  test "should not update entry if longer than 5 mintues since record creation" do
    @request.remote_addr = '5.6.7.8'
    put :update, { :id => 5, :entry => { :verb => 'be uneditable' } }
    assert_redirected_to root_path
    assert_not_nil flash[:error]
  end
end
