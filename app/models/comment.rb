class Comment < ActiveRecord::Base
  include Spammable
  
  # relationships
  
  belongs_to :entry
  belongs_to :user
  
  # validations
  
  validates_presence_of :entry_id, :ip
  validates_presence_of :comment, :message => 'can\'t be blank. You need some drivel in order for it to be pointless.'
  validates_format_of :ip, :with => /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/, :message => 'must be a valid IP.'
  validates_length_of :name, :maximum => 30, :message => 'can\'t be longer than 30 characters. Sucks for you that your name is so long.', :allow_blank => true
  validates_each :name, :comment do |record, attr, value|
    record.errors.add attr, 'cannot contain a URL.' if /.*http:\/\/.*/i.match(value)
  end
  validate :honeypot_must_be_blank
  validate :no_recent_comment_from_ip, :on => :create
  
  # callbacks
  
  after_create :update_comment_count
  
  # accessors
  
  attr_accessor :email
  attr_accessible :name, :comment
  
  # scopes

  scope :without_spam, where('spam = ?', false)

  # methods
  
  private
  
  def honeypot_must_be_blank
    self.errors.add(:base, 'FUCK BOTS.') unless self.email.blank?
  end
  
  def no_recent_comment_from_ip
    errors.add(:base, 'You\'re awfully eager to make everyone listen to you. At least wait a single minute before babbling again.') if Comment.all(:conditions => ['created_at > ? AND ip = ?', Time.new.ago(60).in_time_zone, self.ip]).count > 0
  end
  
  def update_comment_count
    self.entry.increment! :comment_count
  end
end
