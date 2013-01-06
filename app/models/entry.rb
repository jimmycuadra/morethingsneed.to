class Entry < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :noun, :verb
  validates_inclusion_of :needs, in: [true, false]
end
