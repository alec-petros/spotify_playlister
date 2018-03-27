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

  def edit
    set_playlist
  end

  def edit_fix
    set_playlist
    @playlist.artists.delete_all
    @playlist.tracks.delete_all
    @playlist.genres.delete_all
    artists = params[:artists].split(", ")
    tracks = params[:tracks].split(", ")
    @genres = params[:genres]
    @track_arr = tracks.map {|track| Track.find_all_tracks(track)}
    @artist_arr = artists.map {|artist| Artist.find_all_artists(artist)}
    @track_arr.count.times do
      @playlist.tracks.build
    end
    @artist_arr.count.times do
      @playlist.artists.build
    end
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
    @playlist = Playlist.new(name: params[:playlist][:name], user_id: session[:user_id])
    @playlist.render_attributes(params[:playlist][:artists_attributes], params[:playlist][:tracks_attributes], params[:playlist][:genres])
    @playlist.save
    redirect_to @playlist
  end

  def update
    set_playlist
    @playlist.update(params.require(:playlist).permit(:name))
    @playlist.render_attributes(params[:playlist][:artists_attributes], params[:playlist][:tracks_attributes], params[:playlist][:genres])
    @playlist.save
    redirect_to @playlist
  end

  private

  def set_playlist
    @playlist = Playlist.find(params[:id])
  end
end
