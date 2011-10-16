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
    user = populate_user_from_auth_hash(auth_hash)
    create_authentication_for_user_from_auth_hash(user, auth_hash)
    user
  end

  def self.populate_user_from_auth_hash(auth_hash)
    user_params = { name: auth_hash["info"]["name"] }
    user_params[:email] = auth_hash["info"]["email"] if auth_hash["info"]

    User.create! user_params
  end

  def self.create_authentication_for_user_from_auth_hash(user, auth_hash)
    auth_params = {
      provider: auth_hash["provider"],
      uid: auth_hash["uid"]
    }

    if auth_hash["credentials"]
      auth_params[:token] = auth_hash["credentials"]["token"]
      auth_params[:secret] = auth_hash["credentials"]["secret"]
    end

    user.authentications.create! auth_params
  end
end
