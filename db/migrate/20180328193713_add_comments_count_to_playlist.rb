class AddCommentsCountToPlaylist < ActiveRecord::Migration[5.1]
  def change
    add_column :playlists, :comments_count, :integer
  end
end
