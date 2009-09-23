require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "activation_instructions" do
    @expected.subject = 'Notifier#activation_instructions'
    @expected.body    = read_fixture('activation_instructions')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Notifier.create_activation_instructions(@expected.date).encoded
  end

end
