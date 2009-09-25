class Entry < ActiveRecord::Base
  has_many :comments
  has_many :votes
  belongs_to :user
  validates_presence_of :ip
  validates_format_of :ip, :with => /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/, :message => 'must be a valid IP'
  validates_uniqueness_of :noun, :scope => :verb, :message => "^I know you think you're clever, but someone already submitted that one."
  validate :not_default_or_missing_phrase
  
  def not_default_or_missing_phrase
    if (self.noun == 'nouns' and self.verb == 'verb') or (self.noun.blank? and self.verb.blank?)  
      errors.add_to_base("Don't just hit the button! Give it some thought!") 
    elsif self.noun.blank?
      errors.add(:noun, "^Surely SOMETHING needs to " + self.verb + '!')
    elsif self.verb.blank?
      errors.add(:verb, '^Just "' + self.noun + '?" Remember, all things need to do something.' )
    end
  end
  
  def self.per_page
    10
  end
end
