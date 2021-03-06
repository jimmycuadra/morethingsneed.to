class Entry < ActiveRecord::Base
  include Spammable

  # relationships

  has_many :comments, :dependent => :destroy
  has_many :votes, :dependent => :destroy
  belongs_to :user

  # validations

  validates_presence_of :ip
  validates_format_of :ip, :with => /\A(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\z/, :message => 'must be a valid IP.'
  validates_length_of :noun, :verb, :maximum => 255, :message => " is more than 255 characters. You're too wordy."
  validate :not_default_or_missing_phrase
  validate :honeypot_must_be_blank
  validate :unique_entry
  validates_each :noun, :verb do |record, attr, value|
    record.errors.add attr, 'cannot contain a URL.' if /.*http:\/\/.*/i.match(value)
  end
  validate :no_recent_entry_from_ip, :on => :create

  # callbacks

  before_validation :strip_whitespace
  before_validation :strip_trailing_punctuation

  # accessors

  attr_accessor :email, :allow_recent_entry

  # scopes

  def self.recent(page = 1)
    where(spam: false).order(created_at: :desc).paginate(page: page, per_page: 30)
  end

  def self.by_user(user_id)
    where(user_id: user_id)
  end

  def self.without_spam
    where('spam = ?', false)
  end

  # methods

  def not_default_or_missing_phrase
    if (self.noun == 'nouns' and self.verb == 'verb') or (self.noun.blank? and self.verb.blank?)
      errors.add(:base, "Don't just hit the button! Give it some thought!")
    elsif self.noun.blank?
      errors.add(:noun, "is required. A verb without a noun is way too crazy.")
    elsif self.verb.blank?
      errors.add(:verb, 'is required. All things need to do something.' )
    end
  end

  def honeypot_must_be_blank
    errors.add(:base, 'FUCK BOTS.') unless self.email.blank?
  end

  def unique_entry
    matched_entry = Entry.where(['LOWER(noun) = LOWER(?) AND LOWER(verb) = LOWER(?)', self.noun, self.verb]).first
    errors.add(:base, 'I know you think you\'re clever, but someone already submitted that one.') if matched_entry && (matched_entry.id != self.id)
  end

  def no_recent_entry_from_ip
    errors.add(:base, 'Gotta wait at least a minute before adding another one.') if !allow_recent_entry && Entry.where(['created_at > ? AND ip = ?', Time.new.ago(60).in_time_zone, ip]).count > 0
  end

  def strip_whitespace
    self.noun.strip! unless self.noun.nil?
    self.verb.strip! unless self.verb.nil?
  end

  def strip_trailing_punctuation
    self.verb.gsub!(/[\.!?,]*$/, '') unless self.verb.nil?
  end

  def recalculate_comment_count
    self.update_attribute :comment_count, self.comments.where(spam: false).count
  end

  def self.search(query)
    where(search_conditions(query))
  end

  def self.per_page
    10
  end

  private

  def self.search_conditions(query)
    query.split(/\s+/).map do |word|
      '(' + %w[noun verb].map { |col| "#{col} LIKE #{sanitize('%' + word.to_s + '%')}" }.join(' OR ') + ')'
    end.join(' AND ')
  end
end
