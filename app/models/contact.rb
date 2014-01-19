class Contact
  include ActiveModel::Model

  attr_accessor :name, :real_email, :message, :email

  # validations

  validates_presence_of :name
  validates_presence_of :real_email
  validates_presence_of :message
  validates_format_of :real_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :unless => Proc.new { |c| c.real_email.blank? }
  validate :honeypot_should_be_blank

  # methods

  private

  def honeypot_should_be_blank
    errors.add(:base, 'FUCK BOTS.') unless self.email.blank?
  end
end
