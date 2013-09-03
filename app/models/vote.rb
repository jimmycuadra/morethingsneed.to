class Vote < ActiveRecord::Base
  # relationships

  belongs_to :entry
  belongs_to :user

  # validations

  validates_presence_of :entry_id, :ip
  validates_inclusion_of :up_vote, :in => [true, false]
  validates_format_of :ip, :with => /\A(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\z/, :message => 'must be a valid IP.'
  validates_uniqueness_of :ip, :scope => [:entry_id]

  # callbacks

  after_save :update_vote_counts

  # methods

  private

  def update_vote_counts
    count_to_increment = (self.up_vote) ? :up_vote_count : :down_vote_count
    self.entry.increment count_to_increment
    self.entry.save
  end
end
