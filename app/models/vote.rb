class Vote < ActiveRecord::Base
  # relationships
  
  belongs_to :entry
  belongs_to :user
  
  # validations
  
  validates_presence_of :entry_id, :ip
  validates_inclusion_of :up_vote, :in => [true, false]
  validates_format_of :ip, :with => /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/, :message => 'must be a valid IP'
  validate :no_existing_vote_from_this_ip
  
  # callbacks
  
  after_save :update_vote_counts
  
  # accessors
  
  attr_accessible :up_vote
  
  # methods
  
  private
  
  def no_existing_vote_from_this_ip
    errors.add_to_base('We already got your vote on this one.') if Vote.all(:conditions => ['entry_id = ? AND ip = ?', self.entry_id, self.ip]).count > 0
  end
  
  def update_vote_counts
    count_to_increment = (self.up_vote) ? :up_vote_count : :down_vote_count
    self.entry.increment count_to_increment
    self.entry.save
  end
end
