# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_fb_likes_session',
  :secret      => '1f1e67e6ce4a4c2e9acd0a9a4621d552fc5b2e25dc291d7e768ebe3377efa22012549e8ca333e11647bee02c77a32d4444172f92b32a72c596f0407273d344f4'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
