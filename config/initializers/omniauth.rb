require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, "2bddb2de8f6b4b7792f99cdb8aecbe19", "a5f9a55ab0db42f68a3c02cdab76fb61", scope: 'user-read-email playlist-modify-public user-library-read user-library-modify'
end
