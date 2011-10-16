class User < ActiveRecord::Base
  has_many :authentications

  validates :name, presence: true

  def self.find_or_create_via_auth_hash(auth_hash)
    auth = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
    return auth.user if auth

    create_via_auth_hash(auth_hash)
  end

  private

  def self.create_via_auth_hash(auth_hash)
    user = User.create(name: auth_hash["info"]["name"], email: auth_hash["info"]["email"])
    user.authentications.create!(
      provider: auth_hash["provider"],
      uid: auth_hash["uid"],
      token: auth_hash["credentials"]["token"],
      secret: auth_hash["credentials"]["secret"]
    )
    user
  end
end
