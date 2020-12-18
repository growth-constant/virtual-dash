# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_16_231356) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "race_categories", force: :cascade do |t|
    t.string "title"
    t.decimal "price", precision: 10, scale: 2
    t.bigint "race_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["race_id"], name: "index_race_categories_on_race_id"
  end

  create_table "race_tries", force: :cascade do |t|
    t.bigint "registration_id", null: false
    t.bigint "user_id", null: false
    t.string "segment_id"
    t.integer "duration"
    t.datetime "start"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["registration_id"], name: "index_race_tries_on_registration_id"
    t.index ["start"], name: "index_race_tries_on_start"
    t.index ["user_id"], name: "index_race_tries_on_user_id"
  end

  create_table "races", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "country"
    t.string "state"
    t.string "city"
    t.datetime "enddate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "segment_id"
    t.boolean "published"
    t.datetime "startdate"
  end

  create_table "registrations", force: :cascade do |t|
    t.bigint "race_id", null: false
    t.bigint "user_id", null: false
    t.bigint "race_category_id", null: false
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["race_category_id"], name: "index_registrations_on_race_category_id"
    t.index ["race_id"], name: "index_registrations_on_race_id"
    t.index ["user_id"], name: "index_registrations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "image"
    t.string "token"
    t.integer "token_expires_at"
    t.string "refresh_token"
    t.string "first_name"
    t.string "last_name"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "image_medium"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "race_categories", "races"
  add_foreign_key "race_tries", "registrations"
  add_foreign_key "race_tries", "users"
  add_foreign_key "registrations", "race_categories"
  add_foreign_key "registrations", "races"
  add_foreign_key "registrations", "users"
end
