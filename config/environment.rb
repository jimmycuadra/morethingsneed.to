# Load the rails application
require File.expand_path('../application', __FILE__)
require File.join(File.dirname(__FILE__), '/../lib/ip_maker')

# Initialize the rails application
Morethingsneed::Application.initialize!
