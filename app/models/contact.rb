class Contact < ActiveRecord::Base
  # tableless model
  
  def self.columns()
    @columns ||= []
  end
  
  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)
  end
  
  column :name, :string
  column :real_email, :string
  column :message, :text
  column :email, :string
  
  # validations
  
  validates_presence_of :name, :message => '^Who are you?'
  validates_presence_of :real_email, :message => '^How are we going to get back to you without your e-mail address?'
  validates_presence_of :message, :message => '^Why contact us if you have nothing to say?'
  validates_format_of :real_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => '^Don\'t try to fake us out. We know that e-mail address is no good.', :unless => Proc.new { |c| c.real_email.blank? }
  validate :honeypot_should_be_blank
  
  # methods
  
  private
  
  def honeypot_should_be_blank
    errors.add_to_base('FUCK BOTS') unless self.email.blank?
  end
end