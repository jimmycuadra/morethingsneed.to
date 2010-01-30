require 'test_helper'

class BannedIpTest < ActiveSupport::TestCase
  def setup
    @b = BannedIp.new
  end
  
  test "should reject invalid ip" do
    @b.ip = 'internet protocol'
    assert !@b.valid?
    assert @b.errors.invalid?(:ip)
  end
  
  test "should not return banned ip record" do
    assert_nil BannedIp.is_banned?('0.0.0.0')
  end
  
  test "should return banned ip record" do
    assert_not_nil BannedIp.is_banned?('255.255.255.255')
  end
  
  test "should ban ip" do
    assert_difference 'BannedIp.count', 1 do
      BannedIp.toggle_ban('0.0.0.0')
    end
  end
  
  test "should unban ip" do
    assert_difference 'BannedIp.count', -1 do
      BannedIp.toggle_ban('255.255.255.255')
    end
  end
end
