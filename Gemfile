source "https://rubygems.org"

gem "rails"
gem "thin"
gem "haml"
gem "strong_parameters"
gem "omniauth-facebook"
gem "omniauth-twitter"
gem "omniauth-google-oauth2"

group :assets do
  gem "sass-rails"
  gem "bootstrap-sass"
  gem "coffee-rails"
  gem "uglifier"
end

group :production do
  gem "pg"
end

group :development, :test do
  gem "sqlite3"
end

group :development do
  gem "foreman"
end

group :test do
  gem "rspec-rails"
  gem "capybara", require: "capybara/rspec"
  gem "capybara-webkit"
  gem "simplecov", require: false
end
