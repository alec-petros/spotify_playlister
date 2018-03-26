class Artist < ApplicationRecord
  has_many :tracks
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :playlists

  def self.find_artist(name)
    artist = Artist.find_by(name: name)
    if !artist
      artist = spot_artist_search(name)
    end
    artist
  end

  def self.spot_artist_search(name)
    artist = RSpotify::Artist.search(name)[0]
    if artist
      output = Artist.new(name: artist.name, spot_id: artist.id)
      artist.genres.each do |genre|
        output.genres << Genre.find_or_create_by(name: genre)
      end
      output.save
    end
    return output
  end

end
