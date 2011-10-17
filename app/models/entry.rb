class Entry < ActiveRecord::Base
  attr_accessible :noun, :verb, :needs

  belongs_to :user

  validates :noun, presence: true
  validates :verb, presence: true
  validates :needs, inclusion: { in: [true, false] }
  validates :user_id, presence: true
  validate  :uniqueness_of_entry

  def uniqueness_of_entry
    matched_entry = Entry.where(['LOWER(noun) = LOWER(?) AND LOWER(verb) = LOWER(?)', noun, verb]).first
    if matched_entry && (matched_entry.id != id)
      errors.add(:base, 'Entry is not unique.')
    end
  end
end
