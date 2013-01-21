class Authentication < ActiveRecord::Base
  class PersonaAssertionError < StandardError; end

  belongs_to :user

  class << self
    def from_omniauth(auth)
      where(auth.slice("provider", "uid")).first || create_with_omniauth(auth)
    end

    def from_persona(assertion)
      response = Faraday.post("https://verifier.login.persona.org/verify", {
        assertion: assertion,
        audience: Rails.configuration.persona_audience
      })

      persona_details = MultiJson.load(response.body)

      unless persona_details["status"] == "okay"
        raise PersonaAssertionError.new(persona_details["reason"])
      end

      authentication = where(
        provider: "persona",
        uid: persona_details["email"]
      ).first

      authentication || create_with_persona(persona_details)
    end

    private

    def create_with_omniauth(auth)
      user = User.create do |user|
        user.name = auth["info"]["name"]
        user.authentications.build(auth.slice("provider", "uid"))
      end

      user.authentications.first
    end

    def create_with_persona(persona_details)
      user = User.create do |user|
        user.name = "Unnamed User"
        user.authentications.build(
          provider: "persona",
          uid: persona_details["email"]
        )
      end

      user.authentications.first
    end
  end
end
