class Artist < ApplicationRecord
  serialize :images, Array
  has_many :tracks
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :playlists

  include PlaylistHelpers

  def self.find_all_artists(name)
    RSpotify::Artist.search(name)
  end

  def self.find_artist(spot_id)
    artist = Artist.find_by(spot_id: spot_id)
    if !artist
      artist = spot_artist_find(spot_id)
    end
    artist
  end

  def self.spot_artist_find(spot_id)
    # byebug
    artist = RSpotify::Artist.find(spot_id)
    output = Artist.new(name: artist.name, spot_id: artist.id, images: artist.images, popularity: artist.popularity)
    artist.genres.each do |genre|
      output.genres << Genre.find_or_create_by(name: genre)
    end
    output.save
    return output
  end

end
