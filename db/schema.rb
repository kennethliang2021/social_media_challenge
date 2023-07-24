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

ActiveRecord::Schema[7.0].define(version: 2023_07_24_065245) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "custom_list_people", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.bigint "custom_list_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["custom_list_id"], name: "index_custom_list_people_on_custom_list_id"
  end

  create_table "custom_lists", force: :cascade do |t|
    t.string "name"
    t.bigint "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_custom_lists_on_team_id"
  end

  create_table "federal_legislators", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "social_media_people_identifiers", force: :cascade do |t|
    t.string "identifier"
    t.bigint "social_media_type_id", null: false
    t.string "identifiable_type", null: false
    t.bigint "identifiable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identifiable_type", "identifiable_id"], name: "index_social_media_people_identifiers_on_identifiable"
    t.index ["social_media_type_id"], name: "index_social_media_people_identifiers_on_social_media_type_id"
  end

  create_table "social_media_posts", force: :cascade do |t|
    t.datetime "posted_at"
    t.bigint "social_media_people_identifier_id", null: false
    t.text "content"
    t.string "post_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["social_media_people_identifier_id"], name: "index_social_media_posts_on_social_media_people_identifier_id"
  end

  create_table "social_media_types", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "custom_list_people", "custom_lists"
  add_foreign_key "custom_lists", "teams"
  add_foreign_key "social_media_people_identifiers", "social_media_types"
  add_foreign_key "social_media_posts", "social_media_people_identifiers"
end
