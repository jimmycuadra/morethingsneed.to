# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_morethingsneed_session',
  :secret      => 'd41b3952b16eaae2d54d6eb2181d54e18af41dbd5c25e0ad7ed45c0e6e05af6ccd19aae8af6c9d431e9c58fa40f975d4c55d455e1b67bd14a9d349f05642ad6c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
