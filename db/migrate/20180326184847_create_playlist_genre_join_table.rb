class CreatePlaylistGenreJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :playlists, :genres do |t|
      # t.index [:playlist_id, :genre_id]
      # t.index [:genre_id, :playlist_id]
    end
  end
end
