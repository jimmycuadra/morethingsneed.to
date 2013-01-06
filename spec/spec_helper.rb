ENV["RAILS_ENV"] ||= "test"

require "simplecov"
SimpleCov.start "rails"

require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.order = "random"

  config.around(:each, disable_omniauth_test_mode: true) do |example|
    OmniAuth.config.test_mode = false
    example.run
    OmniAuth.config.test_mode = true
  end
end

Capybara.javascript_driver = :webkit
