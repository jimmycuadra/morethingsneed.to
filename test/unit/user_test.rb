require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users
  
  def setup
    @u = User.new()
  end
  
  test "should show inactive user as inactive" do
    @u = users(:bongo)
    assert !@u.active?
  end
  
  test "should activate user" do
    @u = users(:bongo)
    @u.activate!
    assert @u.active?
  end
end
