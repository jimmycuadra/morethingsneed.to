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
end
