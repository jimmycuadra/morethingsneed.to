require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    Entry.create(:noun => 'tests', :verb => 'run', :ip => generate_ip)
    @c = Entry.last.comments.build(:comment => 'A comment.', :ip => generate_ip)
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
  
  test "should reject comment with filled in honeypot" do
    @c.email = 'honey is tasty'
    assert !@c.valid?
    assert @c.errors.invalid?(:base)
  end

  test "should reject 2nd comment from IP within 1 minute" do
    ip = @c.ip
    assert @c.save
    @c2 = Entry.last.comments.build(:comment => 'A comment.', :ip => ip)
    assert !@c2.valid?, 'Second comment from IP was accepted'
    assert @c2.errors.invalid?(:base)
  end
end
