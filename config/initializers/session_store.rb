# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_lahaina_session',
  :secret      => 'a0e952712c4ec780ca82314771ba561820b0aee21eff26c426c3d364dae6273e15697d28e7e5f2b7760f74738c87ea1ceb4a7baba6e8f3669c9cd1c17b4d8c2b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
