class Track < ApplicationRecord
  belongs_to :artist
  has_and_belongs_to_many :playlists

  def self.spot_track_search(name)
    track = RSpotify::Track.search(name)[0]
    if track
      artist = track.artists[0].name
      output = Track.new(name: track.name, spot_id: track.id, artist: Artist.find_artist(artist))
    end
    output
  end
end
