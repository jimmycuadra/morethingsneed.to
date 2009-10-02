class Comment < ActiveRecord::Base
  belongs_to :entry
  belongs_to :user
  validates_presence_of :entry_id, :ip
  validates_presence_of :comment, :message => '^Umm, you need some drivel in order for it to be pointless.'
  validates_format_of :ip, :with => /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/, :message => 'must be a valid IP'
  validates_length_of :name, :maximum => 30, :message => '^Sucks for you that your name is so long, because names longer than 30 characters aren\'t accepted.', :allow_blank => true
  validate :honeypot_must_be_blank
  attr_accessor :email
  
  def honeypot_must_be_blank
    self.errors.add_to_base('FUCK BOTS') unless self.email.blank?
  end
end
