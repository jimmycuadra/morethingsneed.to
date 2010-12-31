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
    assert @e.errors[:base].any?
    assert @e.errors[:ip].any?
  end
  
  test "should reject default values" do
    @e.noun = 'nouns'
    @e.verb = 'verb'
    assert !@e.valid?
    assert @e.errors[:base].any?
  end
  
  test "should reject missing noun" do
    @e.noun = ''
    assert !@e.valid?
    assert @e.errors[:noun].any?
  end
  
  test "should reject missing verb" do
    @e.verb = ''
    assert !@e.valid?
    assert @e.errors[:verb].any?
  end
  
  test "should reject invalid ip" do
    @e.ip = 'internet protocol'
    assert !@e.valid?
    assert @e.errors[:ip].any?
  end
  
  test "should reject duplicate entry" do
    @e.noun = 'PiGS'
    @e.verb = 'SQueAK'
    assert !@e.valid?
    assert @e.errors[:base].any?
  end
    
  test "should reject filled in honeypot" do
    @e.email = 'honey is tasty'
    assert !@e.valid?
    assert @e.errors[:base].any?
  end
  
  test "should reject 2nd entry from IP within 1 minute" do
    assert @e.save
    @e2 = Entry.new(:noun => 'another', :verb => 'entry')
    @e2.ip = @e.ip
    assert !@e2.valid?, 'Second entry from IP was accepted'
    assert @e2.errors[:base].any?
  end
  
  test "should allow 2nd entry from IP within 1 minute if flag is set" do
    assert @e.save
    @e2 = Entry.new(:noun => 'another', :verb => 'entry')
    @e2.ip = @e.ip
    @e2.allow_recent_entry = true
    assert @e2.valid?, 'Second entry from IP with allow flag set was invalid'
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
    @e.verb = 'run!?.,'
    @e.save
    assert_equal @e.verb, 'run'
  end
  
  test "should strip whitespace" do
    @e.noun = '  tests  '
    @e.verb = '  run  '
    @e.save
    assert_equal @e.noun, 'tests'
    assert_equal @e.verb, 'run'
  end
  
  test "should reject entry with URL in it" do
    @e.noun = @e.verb = 'testing Http://www.spam.com/ comments'
    assert !@e.valid?
    assert @e.errors[:noun].any?
    assert @e.errors[:verb].any?
  end
  
  test "should reject entry with noun or verb longer than 255 characters" do
    @e.noun = @e.verb = 'abcdefghijklmnopqrstuvwxyz abcdefghijklmnopqrstuvwxyz abcdefghijklmnopqrstuvwxyz abcdefghijklmnopqrstuvwxyz abcdefghijklmnopqrstuvwxyz abcdefghijklmnopqrstuvwxyz abcdefghijklmnopqrstuvwxyz abcdefghijklmnopqrstuvwxyz abcdefghijklmnopqrstuvwxyz abcdefghijklmnopqrstuvwxyz'
    assert !@e.valid?
    assert @e.errors[:noun].any?
    assert @e.errors[:verb].any?
  end
  
  test "should toggle spam" do
    @e = Entry.first
    initial_spam_value = @e.spam
    @e.toggle_spam
    assert_not_equal @e.spam, initial_spam_value
  end
  
  test "should reject entry from banned IP" do
    @e.ip = '6.6.6.6'
    assert !@e.valid?
    assert @e.errors[:base].any?
  end

  test "should find matching records when searching" do
    assert_equal Entry.search('pigs'), [Entry.find(1)]
    assert_equal Entry.search('meow'), [Entry.find(2)]
  end

  test "should scope lookup to user" do
    assert_equal Entry.by_user(1), [Entry.find_by_user_id(1)]
  end

  test "should scope lookup by spam flag" do
    assert_equal Entry.without_spam.count, 4
  end
end
