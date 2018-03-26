class CreateTracks < ActiveRecord::Migration[5.1]
  def change
    create_table :tracks do |t|
      t.string :name
      t.integer :artist_id
      t.string :spot_id

      t.timestamps
    end
  end
end
