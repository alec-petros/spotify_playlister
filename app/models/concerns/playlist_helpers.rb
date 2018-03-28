module PlaylistHelpers
  def recent_playlists
    playlists.order("created_at DESC")
  end
end
