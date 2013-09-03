class Contact
  include ActiveModel::Model

  attr_accessor :name, :real_email, :message, :email

  # validations

  validates_presence_of :name, :message => 'is required. Who are you?'
  validates_presence_of :real_email, :message => 'is required. How are we going to get back to you without your e-mail address?'
  validates_presence_of :message, :message => 'is required. Why contact us if you have nothing to say?'
  validates_format_of :real_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => 'must be valid. Don\'t try to fake us out.', :unless => Proc.new { |c| c.real_email.blank? }
  validate :honeypot_should_be_blank

  # methods

  private

  def honeypot_should_be_blank
    errors.add(:base, 'FUCK BOTS.') unless self.email.blank?
  end
end
