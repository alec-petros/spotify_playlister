class CreatePlaylistArtistJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :playlists, :artists do |t|
      # t.index [:playlist_id, :artist_id]
      # t.index [:artist_id, :playlist_id]
    end
  end
end
