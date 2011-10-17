class Authentication < ActiveRecord::Base
  attr_accessible :provider, :uid, :token, :secret

  belongs_to :user

  validates :user_id, presence: true
  validates :provider, presence: true
  validates :uid, presence: true
end
