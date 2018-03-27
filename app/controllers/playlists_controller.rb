class PlaylistsController < ApplicationController

  def index
    @playlists = Playlist.all.order("created_at DESC")
  end

  def new
    @playlist = Playlist.new
  end

  def show
    set_playlist
  end

  def generate
    set_playlist
    @playlist_array = @playlist.generate.tracks
    # byebug
  end

  def create
    @playlist = Playlist.new(name: params[:playlist][:name], user_id: session[:user_id])
    artists = params[:playlist][:artists].split(", ")
    tracks = params[:playlist][:tracks].split(", ")
    genres = params[:playlist][:genres].split(", ")
    artists.each do |artist|
      @playlist.artists << Artist.find_artist(artist)
    end
    tracks.each do |track|
      @playlist.tracks << Track.find_track(track)
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
