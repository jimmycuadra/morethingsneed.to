source "https://rubygems.org"

gem "rails"
gem "thin"
gem "haml"
gem "strong_parameters"
gem "will_paginate"
gem "omniauth-facebook"
gem "omniauth-twitter"
gem "omniauth-google-oauth2"
gem "omniauth-identity"

group :assets do
  gem "sass-rails"
  gem "bootstrap-sass"
  gem "coffee-rails"
  gem "uglifier"
  gem "haml_coffee_assets"
end

group :production do
  gem "pg"
end

group :development, :test do
  gem "sqlite3"
  gem "pry-rails"
  gem "pry-nav"
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
