class User < ActiveRecord::Base
  has_many :authentications
  has_many :entries
end
