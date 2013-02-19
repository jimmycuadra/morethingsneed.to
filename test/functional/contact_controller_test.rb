require 'test_helper'

class ContactControllerTest < ActionController::TestCase
  def setup
    @c = { :name => 'Chester the Tester', :real_email => 'chester@test.com', :message => 'Testing!' }
  end
  test "should render new" do
    get :index
    assert_template :new
  end

  test "should show new contact form" do
    get :new
    assert_response :success
  end

  test "should accept valid contact" do
    post :create, :contact => @c
    assert_redirected_to :action => "new"
  end

  test "should reject invalid contact" do
    @c[:message] = nil
    post :create, :contact => @c
    assert_template :new
    assert_not_nil flash[:error]
  end
end
