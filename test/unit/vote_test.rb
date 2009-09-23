require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  def setup
    @v = Entry.last.votes.build(:ip => '127.0.0.1')
  end
  
  test "should accept valid vote" do
    assert @v.valid?
  end
  
  test "should reject empty vote" do
    @v = Vote.new
    assert !@v.valid?
    assert @v.errors.invalid?(:ip)
    assert @v.errors.invalid?(:entry_id)
  end
  
  test "should reject invalid ip" do
    @v.ip = 'internet protocol'
    assert !@v.valid?
    assert @v.errors.invalid?(:ip)
  end
end
