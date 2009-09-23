require 'test_helper'

class EntryTest < ActiveSupport::TestCase
  fixtures :entries
  
  def setup
    @e = Entry.new(:noun => 'tests', :verb => 'run', :ip => '127.0.0.1')
  end
  
  test "should accept valid entry" do
    assert @e.valid?
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
    @e.noun = 'pigs'
    @e.verb = 'squeak'
    assert !@e.valid?
    assert @e.errors.invalid?(:noun)
  end
end
