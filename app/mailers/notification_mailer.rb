class NotificationMailer < ActionMailer::Base
  default :from => "webmaster@morethingsneed.to"

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
    mail(:to => 'jimmycuadra@gmail.com, michael.chadwick@gmail.com', subject => 'MTNT Contact Form Submission')
  end
end
