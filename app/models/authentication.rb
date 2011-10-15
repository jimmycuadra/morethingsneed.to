class Authentication < ActiveRecord::Base
  has_one :user

  validates :user, presence: true
  validates :provider, presence: true
  validates :uid, presence: true
end
