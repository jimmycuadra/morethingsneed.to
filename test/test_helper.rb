ENV["RAILS_ENV"] = "test"
ENV["JIMMY_EMAIL"] ||= "jimmy@example.com"
ENV["MIKE_EMAIL"] ||= "mike@example.com"

require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'rails/test_help'
require 'authlogic/test_case'

class ActiveSupport::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
  fixtures :all

  def generate_ip
    rand(255).to_s + '.' + rand(255).to_s + '.' + rand(255).to_s + '.' + rand(255).to_s
  end
end
