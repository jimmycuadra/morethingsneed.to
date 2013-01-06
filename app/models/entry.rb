class Entry < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :noun, :verb
  validates_inclusion_of :needs, in: [true, false]

  def self.recent(page_number = 1)
    page(page_number).order("created_at DESC")
  end
end
