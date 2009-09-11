class Entry < ActiveRecord::Base
  has_many :comments
  has_many :votes
  validates_presence_of :noun, :verb, :ip
  validates_format_of :ip, :with => /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/, :message => 'must be a valid IP'
end
