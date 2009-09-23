class Notifier < ActionMailer::Base
  def activation_instructions(user)
    subject    'Activation instructions for morethingsneed.to'
    recipients user.email
    from       'do-not-reply@morethingsneed.to'
    sent_on    Time.now
    body       :username => user.username, :account_activation_url => activate_url(user.perishable_token)
  end
end
