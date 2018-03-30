class Track < ApplicationRecord
  serialize :images, Array
  belongs_to :artist
  has_and_belongs_to_many :playlists

  include PlaylistHelpers

  class MyTrack
    attr_accessor :name, :artist, :id
    def initialize(track)
      @name = track.name
      @artist = track.artists[0].name
      @id = track.id
    end

    def track_string
      "#{@name}, #{@artist}"
    end
  end

  def self.find_all_tracks(name)
    track_arr = RSpotify::Track.search(name)
    output = track_arr.map do |t|
      MyTrack.new(t)
    end
    output
  end

  def self.find_track(spot_id)
    track = Track.find_by(spot_id: spot_id)
    if !track
      track = spot_track_find(spot_id)
    end
    track
  end

  def self.spot_track_find(spot_id)
    track = RSpotify::Track.find(spot_id)
    artist = track.artists[0].id
    output = Track.new(name: track.name,
      spot_id: track.id,
      artist: Artist.find_artist(artist),
      images: track.album.images,
      acousticness: track.audio_features.acousticness,
      danceability: track.audio_features.danceability,
      energy: track.audio_features.energy,
      instrumentalness: track.audio_features.instrumentalness,
      liveness: track.audio_features.liveness,
      speechiness: track.audio_features.speechiness,
      tempo: track.audio_features.tempo,
      valence: track.audio_features.valence,
      time_signature: track.audio_features.time_signature,
      key: track.audio_features.key,
      mode: track.audio_features.mode)
    output.save
    output
  end

end
