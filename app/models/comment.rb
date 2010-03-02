class Comment < ActiveRecord::Base
  include Spammable
  
  # relationships
  
  belongs_to :entry
  belongs_to :user
  
  # validations
  
  validates_presence_of :entry_id, :ip
  validates_presence_of :comment, :message => '^Umm, you need some drivel in order for it to be pointless.'
  validates_format_of :ip, :with => /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/, :message => 'must be a valid IP'
  validates_length_of :name, :maximum => 30, :message => '^Sucks for you that your name is so long, because names longer than 30 characters aren\'t accepted.', :allow_blank => true
  validate :honeypot_must_be_blank
  validate_on_create :no_recent_comment_from_ip
  
  # callbacks
  
  after_create :update_comment_count
  
  # accessors
  
  attr_accessor :email
  attr_accessible :name, :comment
  
  # methods
  
  private
  
  def honeypot_must_be_blank
    self.errors.add_to_base('FUCK BOTS') unless self.email.blank?
  end
  
  def no_recent_comment_from_ip
    errors.add_to_base('You\'re awfully eager to make everyone listen to you. At least wait a single minute before babbling again.') if Comment.all(:conditions => ['created_at > ? AND ip = ?', Time.new.ago(60).in_time_zone, self.ip]).count > 0
  end
  
  def update_comment_count
    self.entry.increment! :comment_count
  end
end
