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
    output = Track.new(name: track.name, spot_id: track.id, artist: Artist.find_artist(artist), images: track.album.images)
    output.save
    output
  end

end
