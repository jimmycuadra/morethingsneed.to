class Authentication < ActiveRecord::Base
  belongs_to :user

  class << self
    def from_omniauth(auth)
      where(auth.slice("provider", "uid")).first || create_with_omniauth(auth)
    end

    private

    def create_with_omniauth(auth)
      user = User.create do |user|
        user.name = auth["info"]["name"]
        user.authentications.build(auth.slice("provider", "uid"))
      end

      user.authentications.first
    end
  end
end
