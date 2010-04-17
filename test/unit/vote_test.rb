require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  def setup
    @e = Entry.new(:noun => 'tests', :verb => 'run')
    @e.ip = generate_ip
    @v = Entry.last.votes.build(:up_vote => 1)
    @v.ip = generate_ip
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

  test "should reject missing up_vote" do
    @v.up_vote = nil
    assert !@v.valid?
    assert @v.errors.invalid?(:up_vote)
  end
  
  test "should increase entry's up_vote_count only" do
    assert_difference('Entry.last.up_vote_count') do
      assert_no_difference('Entry.last.down_vote_count') do
        @v.save
      end
    end
  end
  
  test "should increase entry's down_vote_count only" do
    assert_difference('Entry.last.down_vote_count') do
      assert_no_difference('Entry.last.up_vote_count') do
        @v.up_vote = 0
        @v.save
      end
    end
  end

  test "should reject second vote from same IP" do
    ip = @v.ip
    assert @v.save
    @v2 = Entry.last.votes.build(:up_vote => 1)
    @v2.ip = ip
    assert !@v2.valid?
    assert @v2.errors.invalid?(:ip)
  end
end
