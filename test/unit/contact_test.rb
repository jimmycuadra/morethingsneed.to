require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  def setup
    @c = Contact.new(:name => 'User', :real_email => 'user@website.com', :message => 'Nice site.')
  end
  
  test "should accept valid contact form" do
    assert @c.valid?
  end
  
  test "should reject form with missing fields" do
    @c = Contact.new
    assert !@c.valid?
    assert @c.errors[:name].any?
    assert @c.errors[:real_email].any?
    assert @c.errors[:message].any?
  end
  
  test "should reject filled in honeypot" do
    @c.email = 'bot@bot.com'
    assert !@c.valid?
    assert @c.errors[:base].any?
  end
end
