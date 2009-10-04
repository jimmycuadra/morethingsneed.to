require 'test_helper'

class EntryTest < ActiveSupport::TestCase  
  def setup
    @e = Entry.new(:noun => 'tests', :verb => 'run', :ip => generate_ip)
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
    @e2 = Entry.new(:noun => 'another', :verb => 'entry', :ip => ip)
    assert !@e2.valid?, 'Second entry from IP was accepted'
    assert @e2.errors.invalid?(:base)
  end
end
