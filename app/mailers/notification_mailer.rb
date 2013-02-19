class NotificationMailer < ActionMailer::Base
  default :from => "More Things Need To <webmaster@morethingsneed.to>"

  def activation_instructions(user)
    @user = user
    mail(:to => user.email, :subject => 'Activation instructions for morethingsneed.to')
  end

  def password_reset_instructions(user)
    @user = user
    mail(:to => user.email, :subject => 'Password reset instructions for morethingsneed.to')
  end

  def contact_form(contact)
    @contact = contact
    mail(:to => [ENV['JIMMY_EMAIL'], ENV['MIKE_EMAIL']], :reply_to => @contact.real_email, :subject => 'MTNT Contact Form Submission')
  end
end
