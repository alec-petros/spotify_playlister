class Playlist < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_and_belongs_to_many :tracks
  has_and_belongs_to_many :artists
  has_and_belongs_to_many :genres

  def generate
    args = {}
    if !tracks.empty?
      args[:seed_tracks] = tracks.map(&:spot_id)
    end
    if !artists.empty?
      args[:seed_artists] = artists.map(&:spot_id)
    end
    if !genres.empty?
      args[:seed_genres] = genres.map(&:name).map(&:downcase)
    end
    byebug
    RSpotify::Recommendations.generate(args)
  end
end
