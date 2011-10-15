class User < ActiveRecord::Base
  has_many :authentications

  validates :name, presence: true
end
