class Entry < ActiveRecord::Base
  has_many :comments
  has_many :votes
  belongs_to :user
  validates_presence_of :noun, :verb, :ip
  validates_format_of :ip, :with => /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/, :message => 'must be a valid IP'
  validates_uniqueness_of :noun, :scope => :verb, :message => "I know you think you're clever, but someone already submitted that one."
  validate :not_default
  
  def not_default
    errors.add_to_base("Don't just hit the button! Give it some thought!") if self.noun == 'nouns' and self.verb == 'verb'
  end
end
