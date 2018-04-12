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

  def self.averageAttrs(arr)
    output = {acousticness: 0, danceability: 0, energy: 0, instrumentalness: 0, liveness: 0, speechiness: 0, tempo: 0, valence: 0, time_signature: 0, key: 0, mode:0}
    arr.each do |track|
      output[:acousticness] = (output[:acousticness] + track.acousticness) / 2
      output[:danceability] = (output[:danceability] + track.danceability) / 2
      output[:energy] = (output[:energy] + track.energy) / 2
      output[:instrumentalness] = (output[:instrumentalness] + track.instrumentalness) / 2
      output[:liveness] = (output[:liveness] + track.liveness) / 2
      output[:speechiness] = (output[:speechiness] + track.speechiness) / 2
      output[:tempo] = (output[:tempo] + track.tempo) / 2
      output[:valence] = (output[:valence] + track.valence) / 2
      # output[:time_signature] = (output[:time_signature] + track.time_signature) / 2
      output[:key] = (output[:key] + track.key) / 2
      output[:mode] = (output[:mode] + track.mode) / 2
    end
    return output
  end

  def self.find_track(spot_id)
    track = Track.find_by(spot_id: spot_id)
    if !track
      track = spot_track_find(spot_id)
    end
    track
  end

  # This function should establish an average between 1-10
  # for the array of passed tracks
  # Possibly also grab data from the first couple tracks
  # of each artist
  # iterate through on the show page and give a slider with
  # a range + and - 1 (or .1) from the actual avg value

  # This allows further tweaking of the playlist from the user
  # without them having to know exactly how the
  # attributes work

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
