# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180330164648) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.string "spot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "popularity"
    t.text "images"
  end

  create_table "artists_genres", id: false, force: :cascade do |t|
    t.bigint "artist_id", null: false
    t.bigint "genre_id", null: false
  end

  create_table "artists_playlists", id: false, force: :cascade do |t|
    t.bigint "playlist_id", null: false
    t.bigint "artist_id", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer "user_id"
    t.integer "playlist_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genres_playlists", id: false, force: :cascade do |t|
    t.bigint "playlist_id", null: false
    t.bigint "genre_id", null: false
  end

  create_table "playlists", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "comments_count"
  end

  create_table "playlists_tracks", id: false, force: :cascade do |t|
    t.bigint "playlist_id", null: false
    t.bigint "track_id", null: false
  end

  create_table "tracks", force: :cascade do |t|
    t.string "name"
    t.integer "artist_id"
    t.string "spot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "images"
    t.float "acousticness"
    t.float "danceability"
    t.float "energy"
    t.float "instrumentalness"
    t.float "liveness"
    t.float "speechiness"
    t.float "tempo"
    t.float "valence"
    t.integer "time_signature"
    t.integer "key"
    t.integer "mode"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "display_name"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "spot_hash"
  end

end
