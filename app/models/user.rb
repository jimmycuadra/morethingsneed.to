class User < ActiveRecord::Base
  has_many :authentications
  has_many :entries
  has_many :comments

  validates_presence_of :name
end
