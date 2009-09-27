require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @c = Entry.last.comments.build(:comment => 'A comment.', :ip => '127.0.0.1')
  end
  
  test "should accept valid comment" do
    assert @c.valid?
  end
  
  test "should reject empty comment" do
    @c = Comment.new
    assert !@c.valid?
    assert @c.errors.invalid?(:comment)
    assert @c.errors.invalid?(:ip)
    assert @c.errors.invalid?(:entry_id)
  end
  
  test "should reject invalid ip" do
    @c.ip = 'internet protocol'
    assert !@c.valid?
    assert @c.errors.invalid?(:ip)
  end
  
  test "should reject names longer than 30 characters" do
    @c.name = '0123456789012345678901234567890'
    assert !@c.valid?
    assert @c.errors.invalid?(:name)
  end
end
