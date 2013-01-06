Rails.configuration.middleware.use(OmniAuth::Builder) do
  provider :facebook, ENV["FACEBOOK_KEY"], ENV["FACEBOOK_SECRET"]
  provider :twitter, ENV["TWITTER_KEY"], ENV["TWITTER_SECRET"]
  provider :google_oauth2, ENV["GOOGLE_KEY"], ENV["GOOGLE_SECRET"]
end

OmniAuth.config.logger = Rails.logger

if Rails.env.test?
  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[:default] = {
    "uid" => "1",
    "info" => { "name" => "Bongo" }
  }

  OmniAuth.config.add_mock(:facebook, "provider" => "facebook")
  OmniAuth.config.add_mock(:twitter, "provider" => "twitter")
  OmniAuth.config.add_mock(:google_oauth2, "provider" => "google_oauth2")
end
