class User < ApplicationRecord
  has_secure_password
  has_many :playlists
  has_many :comments
end
