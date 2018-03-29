class PlaylistsController < ApplicationController

  before_action :require_login
  skip_before_action :require_login, only: [:index]

  def index
    case params[:option]
    when "Hot"
      @playlists = Playlist.all.order("comments_count DESC").limit(10)
    when "Recent"
      @playlists = Playlist.all.order("created_at DESC").limit(10)
    else
      @playlists = Playlist.all.order("created_at DESC").limit(10)
    end
  end

  def new
    @playlist = Playlist.new
  end

  def destroy
    set_playlist
    @playlist.destroy
    redirect_to playlists_path
  end

  def save
    set_playlist
    set_spotify_user
    spotlist = @spotify_user.create_playlist!(@playlist.name)
    spotlist.add_tracks!(params[:uri_arr].split)
    redirect_to @playlist
  end

  def show
    @comment = Comment.new
    set_playlist
  end

  def edit
    set_playlist
  end

  def edit_fix
    @name = params[:name]
    set_playlist
    prepare_fix
  end

  def fix
    @playlist = Playlist.new(name: params[:name])
    prepare_fix
  end

  def generate
    set_playlist
    begin
      @playlist_array = @playlist.generate(params[:num]).tracks
      @uri_array = @playlist_array.map(&:uri)
    rescue
      flash[:notice] = "Failed to generate playlist. Try slimming down your seeds."
      redirect_to @playlist
    end
  end

  def create
    @playlist = Playlist.new(name: params[:playlist][:name], user_id: session[:user_id])
    @playlist.render_attributes(params[:playlist][:artists_attributes], params[:playlist][:tracks_attributes], params[:playlist][:genres])
    if @playlist.valid?
      @playlist.save
      redirect_to @playlist
    else
      render "new"
    end
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

  def prepare_fix
    @genres = @playlist.prep_genres(params)
    @track_arr = @playlist.prep_tracks(params)
    @artist_arr = @playlist.prep_artists(params)
    @track_arr.count.times do
      @playlist.tracks.build
    end
    @artist_arr.count.times do
      @playlist.artists.build
    end
  end

  def set_spotify_user
    @user = User.find(session[:user_id])
    @spotify_user = RSpotify::User.new(@user.spot_hash)
  end

  def require_login
    render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false) unless session.include? :user_id
  end

end
