# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_09_22_200040) do
  create_table "match_stat_records", force: :cascade do |t|
    t.string "request_type"
    t.integer "kills"
    t.integer "previous_kills"
    t.integer "assists"
    t.integer "deaths"
    t.integer "mvps"
    t.integer "score"
    t.datetime "timestamp", null: false
    t.integer "steam_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["steam_user_id"], name: "index_match_stat_records_on_steam_user_id"
  end

  create_table "steam_users", force: :cascade do |t|
    t.string "real_name", null: false
    t.string "nickname", null: false
    t.integer "steamid", null: false
    t.integer "kills", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["steamid"], name: "index_steam_users_on_steamid", unique: true
  end

  add_foreign_key "match_stat_records", "steam_users"
end
