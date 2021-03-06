class Genre < ApplicationRecord
  has_and_belongs_to_many :artists
  has_and_belongs_to_many :playlists

  include PlaylistHelpers
end
