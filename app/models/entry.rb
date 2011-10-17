class Entry < ActiveRecord::Base
  attr_accessible :noun, :verb, :needs

  belongs_to :user

  validates :noun, presence: true
  validates :verb, presence: true
  validates :needs, inclusion: { in: [true, false] }
  validates :user_id, presence: true
end
