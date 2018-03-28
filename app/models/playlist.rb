class Playlist < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_and_belongs_to_many :tracks
  has_and_belongs_to_many :artists
  has_and_belongs_to_many :genres
  accepts_nested_attributes_for :tracks, :artists

  validates_length_of :name, minimum: 3, maximum: 30
  validates :user_id, presence: true

  def generate(amt)
    args = {limit: amt}
    if !tracks.empty?
      args[:seed_tracks] = tracks.map(&:spot_id)
    end
    if !artists.empty?
      args[:seed_artists] = artists.map(&:spot_id)
    end
    if !genres.empty?
      args[:seed_genres] = genres.map(&:name).map(&:downcase)
    end
    RSpotify::Recommendations.generate(args)
  end

  def tracks_string
    output = tracks.map(&:name).join(", ") unless !tracks
    output
  end

  def artists_string
    output = artists.map(&:name).join(", ") unless !artists
    output
  end

  def genres_string
    output = genres.map(&:name).join(", ") unless !genres
    output
  end

  def render_attributes(artists, tracks, genres)
    if artists
      artists.each do |k, obj|
        self.artists << Artist.find_artist(obj[:spot_id]) unless !obj[:spot_id]
      end
    end
    if tracks
      tracks.each do |k, obj|
        self.tracks << Track.find_track(obj[:spot_id]) unless !obj[:spot_id]
      end
    end
    if genres
      genres.split(", ").each do |genre|
        self.genres << Genre.find_or_create_by(name: genre)
      end
    end
  end

  def prep_artists(params)
    self.artists.delete_all unless !artists
    params[:artists].split(", ").map {|artist| Artist.find_all_artists(artist)}
  end

  def prep_tracks(params)
    self.tracks.delete_all unless !tracks
    params[:tracks].split(", ").map {|track| Track.find_all_tracks(track)}
  end

  def prep_genres(params)
    self.genres.delete_all unless !genres
    params[:genres]
  end

end
