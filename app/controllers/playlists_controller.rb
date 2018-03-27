class PlaylistsController < ApplicationController

  def index
    @playlists = Playlist.all.order("created_at DESC")
  end

  def new
    @playlist = Playlist.new
  end

  def show
    @comment = Comment.new
    set_playlist
  end

  def fix
    @playlist = Playlist.new(name: params[:name])
    artists = params[:artists].split(", ")
    tracks = params[:tracks].split(", ")
    @genres = params[:genres]
    @track_arr = tracks.map do |track|
      Track.find_all_tracks(track)
    end
    @artist_arr = artists.map {|artist| Artist.find_all_artists(artist)}
    @track_arr.count.times do
      @playlist.tracks.build
    end
    @artist_arr.count.times do
      @playlist.artists.build
    end
  end

  def generate
    set_playlist
    @playlist_array = @playlist.generate.tracks
    # byebug
  end

  def create
    byebug
    @playlist = Playlist.new(name: params[:playlist][:name], user_id: session[:user_id], genres: params[:playlist][:genres].split(", "))
    params[:playlist][:artists_attributes].each do |k, obj|
      @playlist.artists << Artist.find_artist(obj[:spot_id])
    end
    params[:playlist][:tracks_attributes].each do |k, obj|
      @playlist.tracks << Track.find_track(obj[:spot_id])
    end
    genres.each do |genre|
      @playlist.genres << Genre.find_or_create_by(name: genre)
    end
    @playlist.save
    redirect_to @playlist
  end

  private

  def set_playlist
    @playlist = Playlist.find(params[:id])
  end
end
