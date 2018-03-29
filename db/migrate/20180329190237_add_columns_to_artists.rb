class AddColumnsToArtists < ActiveRecord::Migration[5.1]
  def change
    add_column :artists, :popularity, :integer
    add_column :artists, :images, :text
  end
end
