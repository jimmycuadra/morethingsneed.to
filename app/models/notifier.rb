class Notifier < ActionMailer::Base
  def activation_instructions(user)
    subject    'Activation instructions for morethingsneed.to'
    recipients user.email
    from       'webmaster@morethingsneed.to'
    sent_on    Time.now
    body       :username => user.username, :account_activation_url => activate_url(user.perishable_token)
  end
  
  def password_reset_instructions(user)
    subject     'Password reset instructions for morethingsneed.to'
    recipients  user.email
    from        'webmaster@morethingsneed.to'
    sent_on     Time.now
    body        :username => user.username, :reset_password_url => edit_password_reset_url(user.perishable_token)
  end

  def contact_form(contact)
    recipients 'jimmycuadra@gmail.com, michael.chadwick@gmail.com'
    from 'webmaster@morethingsneed.to'
    subject 'MTNT Contact Form Submission'
    sent_on Time.now
    body :contact => contact
  end
end
