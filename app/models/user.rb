class User < ActiveRecord::Base
  has_many :authentications
  has_many :entries

  validates_presence_of :name
end
