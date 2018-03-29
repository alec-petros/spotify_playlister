class AddImagesToTracks < ActiveRecord::Migration[5.1]
  def change
    add_column :tracks, :images, :text
  end
end
