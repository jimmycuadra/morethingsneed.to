class Comment < ActiveRecord::Base
  belongs_to :entry
  belongs_to :user
  validates_presence_of :body, :user_id, :entry_id
end
