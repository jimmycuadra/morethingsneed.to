class User < ActiveRecord::Base
  acts_as_authentic

  has_many :entries
  has_many :comments
  has_many :votes, :through => :entries
  has_many :received_comments, :source => :comments, :through => :entries

  def active?
    active
  end

  def activate!
    self.active = true
    save
  end

  def self.per_page
    10
  end
end
