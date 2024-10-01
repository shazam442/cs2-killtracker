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

ActiveRecord::Schema[7.2].define(version: 2024_10_01_203031) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "killtracker_units", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.bigint "tracked_steam_account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_killtracker_units_on_person_id"
    t.index ["tracked_steam_account_id"], name: "index_killtracker_units_on_tracked_steam_account_id"
  end

  create_table "match_stat_records", force: :cascade do |t|
    t.string "request_type"
    t.integer "kills"
    t.integer "previous_kills"
    t.integer "assists"
    t.integer "deaths"
    t.integer "mvps"
    t.integer "score"
    t.datetime "timestamp", null: false
    t.bigint "steam_account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["steam_account_id"], name: "index_match_stat_records_on_steam_account_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "steam_accounts", force: :cascade do |t|
    t.string "nickname", null: false
    t.bigint "steamid", null: false
    t.integer "kills", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "person_id"
    t.index ["person_id"], name: "index_steam_accounts_on_person_id", unique: true
    t.index ["steamid"], name: "index_steam_accounts_on_steamid", unique: true
  end

  add_foreign_key "killtracker_units", "people"
  add_foreign_key "killtracker_units", "steam_accounts", column: "tracked_steam_account_id"
  add_foreign_key "match_stat_records", "steam_accounts"
  add_foreign_key "steam_accounts", "people"
end
