require 'test_helper'

class BannedIpTest < ActiveSupport::TestCase
  def setup
    @b = BannedIp.new
  end

  test "should reject invalid ip" do
    @b.ip = 'internet protocol'
    assert !@b.valid?
    assert @b.errors[:ip].any?
  end

  test "should not return banned ip record" do
    assert_nil BannedIp.is_banned?('1.2.3.4')
  end

  test "should return banned ip record" do
    assert_not_nil BannedIp.is_banned?('4.5.6.7')
  end

  test "should ban ip" do
    assert_difference 'BannedIp.count', 1 do
      BannedIp.toggle_ban('1.2.3.4')
    end
  end

  test "should unban ip" do
    assert_difference 'BannedIp.count', -1 do
      BannedIp.toggle_ban('4.5.6.7')
    end
  end

  test "should flag associated entries and comments as spam" do
    assert_difference 'Entry.where(spam: false).count', -1 do
      assert_difference 'Comment.where(spam: false).count', -1 do
        BannedIp.toggle_ban('1.2.3.4')
      end
    end
  end

  test "should unflag associated entries and comments as spam" do
    assert_difference 'Entry.where(spam: false).count', 1 do
      assert_difference 'Comment.where(spam: false).count', 1 do
        BannedIp.toggle_ban('4.5.6.7')
      end
    end
  end
end
