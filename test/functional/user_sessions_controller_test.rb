require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase
  fixtures :users
  
  test "should log user in and redirect to root with message" do
    post :create, :user_session => { :username => 'Wongo', :password => 'pass' }
    assert_redirected_to root_path
    assert_not_nil flash[:success]
  end
  
  test "should render new template on bad login" do
    post :create
    assert_template :new
  end
end