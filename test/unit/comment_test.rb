require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @e = Entry.new(:noun => 'tests', :verb => 'run')
    @e.ip = generate_ip
    @e.save
    @c = Entry.last.comments.build(:comment => 'A comment.')
    @c.ip = generate_ip
  end
  
  test "should accept valid comment" do
    assert @c.valid?
  end
  
  test "should reject empty comment" do
    @c = Comment.new
    assert !@c.valid?
    assert @c.errors[:comment].any?
    assert @c.errors[:ip].any?
    assert @c.errors[:entry_id].any?
  end
  
  test "should reject invalid ip" do
    @c.ip = 'internet protocol'
    assert !@c.valid?
    assert @c.errors[:ip].any?
  end
  
  test "should reject names longer than 30 characters" do
    @c.name = '0123456789012345678901234567890'
    assert !@c.valid?
    assert @c.errors[:name].any?
  end
  
  test "should reject comment with URLs in it" do
    @c.name = @c.comment = 'http://spam.com'
    assert !@c.valid?
    assert @c.errors[:name].any?
    assert @c.errors[:comment].any?
  end
  
  test "should reject comment with filled in honeypot" do
    @c.email = 'honey is tasty'
    assert !@c.valid?
    assert @c.errors[:base].any?
  end

  test "should reject 2nd comment from IP within 1 minute" do
    ip = @c.ip
    assert @c.save
    @c2 = Entry.last.comments.build(:comment => 'A comment.')
    @c2.ip = ip
    assert !@c2.valid?, 'Second comment from IP was accepted'
    assert @c2.errors[:base].any?
  end

  test "should toggle spam" do
    @c = Comment.first
    initial_spam_value = @c.spam
    @c.toggle_spam
    assert_not_equal @c.spam, initial_spam_value
  end

  test "should reject comment from banned IP" do
    @c.ip = '6.6.6.6'
    assert !@c.valid?
    assert @c.errors[:base].any?
  end
  
  test "should increase entry's comment count" do
    assert_difference 'Entry.last.comment_count' do
      @c.save
    end
  end

  test "should scope lookup by spam flag" do
    assert_equal Entry.find(1).comments.without_spam.count, 3
  end
end
