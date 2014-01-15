require 'simplecov'

SimpleCov.start 'rails'

require 'securerandom'

ENV["SECRET_TOKEN"] = SecureRandom.hex(64)
ENV["JIMMY_EMAIL"] = "jimmy@example.com"
ENV["JIMMY_PASSWORD"] = SecureRandom.hex(64)
ENV["MIKE_EMAIL"] = "mike@example.com"
ENV["MIKE_PASSWORD"] = SecureRandom.hex(64)

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
end
