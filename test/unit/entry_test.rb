require 'test_helper'

class EntryTest < ActiveSupport::TestCase  
  def setup
    @e = Entry.new(:noun => 'tests', :verb => 'run')
    @e.ip = generate_ip
  end
  
  test "should accept valid entry" do
    assert @e.valid?, @e.errors.inspect
  end
  
  test "should reject empty entry" do
    @e = Entry.new
    assert !@e.valid?
    assert @e.errors.invalid?(:base)
    assert @e.errors.invalid?(:ip)
  end
  
  test "should reject default values" do
    @e.noun = 'nouns'
    @e.verb = 'verb'
    assert !@e.valid?
    assert @e.errors.invalid?(:base)
  end
  
  test "should reject missing noun" do
    @e.noun = ''
    assert !@e.valid?
    assert @e.errors.invalid?(:noun)
  end
  
  test "should reject missing verb" do
    @e.verb = ''
    assert !@e.valid?
    assert @e.errors.invalid?(:verb)
  end
  
  test "should reject invalid ip" do
    @e.ip = 'internet protocol'
    assert !@e.valid?
    assert @e.errors.invalid?(:ip)
  end
  
  test "should reject duplicate entry" do
    Entry.create(:noun => 'pigs', :verb => 'squeak', :ip => generate_ip)
    @e.noun = 'pigs'
    @e.verb = 'squeak'
    assert !@e.valid?
    assert @e.errors.invalid?(:noun)
  end
  
  test "should reject filled in honeypot" do
    @e.email = 'honey is tasty'
    assert !@e.valid?
    assert @e.errors.invalid?(:base)
  end
  
  test "should reject 2nd entry from IP within 1 minute" do
    ip = @e.ip
    assert @e.save
    @e2 = Entry.new(:noun => 'another', :verb => 'entry')
    @e2.ip = ip
    assert !@e2.valid?, 'Second entry from IP was accepted'
    assert @e2.errors.invalid?(:base)
  end
  
  test "should destroy child comments and votes along with entry" do
    @e.save
    @e.comments.create(:comment => 'Comment', :ip => generate_ip)
    @e.votes.create(:up_vote => 1, :ip => generate_ip)
    id = @e.id
    @e.destroy
    assert_equal(Comment.all(:conditions => { :entry_id => id }).size, 0)
    assert_equal(Vote.all(:conditions => { :entry_id => id }).size, 0)
  end
  
  test "should remove trailing punctuation" do
    @e.verb = 'run!?.'
    @e.save
    assert_equal @e.verb, 'run'
  end
  
  test "should reject entry with URL in it" do
    @e.noun = @e.verb = 'testing Http://www.spam.com/ comments'
    assert !@e.valid?
    assert @e.errors.invalid?(:noun)
    assert @e.errors.invalid?(:verb)
  end
  
  test "should reject entry with noun or verb longer than 255 characters" do
    @e.noun = @e.verb = 'abcdefghijklmnopqrstuvwxyz abcdefghijklmnopqrstuvwxyz abcdefghijklmnopqrstuvwxyz abcdefghijklmnopqrstuvwxyz abcdefghijklmnopqrstuvwxyz abcdefghijklmnopqrstuvwxyz abcdefghijklmnopqrstuvwxyz abcdefghijklmnopqrstuvwxyz abcdefghijklmnopqrstuvwxyz abcdefghijklmnopqrstuvwxyz'
    assert !@e.valid?
    assert @e.errors.invalid?(:noun)
    assert @e.errors.invalid?(:verb)
  end
  
  test "should toggle spam" do
    @e = Entry.first
    initial_spam_value = @e.spam
    @e.toggle_spam
    assert_not_equal @e.spam, initial_spam_value
  end
end
