class Entry < ActiveRecord::Base
  belongs_to :user
  attr_accessible :noun, :verb, :needs
end
