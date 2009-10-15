class Entry < ActiveRecord::Base
  has_many :comments, :dependent => :destroy
  has_many :votes, :dependent => :destroy
  belongs_to :user
  # validates_presence_of :ip
  validates_format_of :ip, :with => /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/, :message => 'must be a valid IP'
  validates_uniqueness_of :noun, :scope => :verb, :message => "^I know you think you're clever, but someone already submitted that one."
  validate :not_default_or_missing_phrase
  validate :honeypot_must_be_blank
  validate_on_create :no_recent_entry_from_ip
  before_save :strip_trailing_punctuation
  attr_accessor :email
  
  def not_default_or_missing_phrase
    if (self.noun == 'nouns' and self.verb == 'verb') or (self.noun.blank? and self.verb.blank?)  
      errors.add_to_base("Don't just hit the button! Give it some thought!") 
    elsif self.noun.blank?
      errors.add(:noun, "^Surely SOMETHING needs to " + self.verb + '!')
    elsif self.verb.blank?
      errors.add(:verb, '^Just "' + self.noun + '?" Remember, all things need to do something.' )
    end
  end
  
  def honeypot_must_be_blank
    errors.add_to_base('FUCK BOTS.') unless self.email.blank?
  end
  
  def no_recent_entry_from_ip
    errors.add_to_base('Gotta wait at least a minute before adding another one.') if Entry.all(:conditions => ['created_at > ? AND ip = ?', Time.new.ago(60).in_time_zone, self.ip]).count > 0
  end
  
  def strip_trailing_punctuation
    self.verb.gsub!(/[\.!?]*/, '')
  end
  
  def self.per_page
    10
  end
end
