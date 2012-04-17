# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_cache_session',
  :secret      => '47a4976ebedf688a9871c15dfee1fbfa02b255a0cf1a63a44e5c0c766e805262a4e403171d7712e7cd9807d2d072adf153ef3932814665945e02e17c3fa3fc12'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
