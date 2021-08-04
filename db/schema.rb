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

ActiveRecord::Schema.define(version: 2021_08_03_220140) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "prizes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "race_id", null: false
    t.integer "amount", null: false
    t.string "currency", default: "usd", null: false
    t.string "strpe_transfer_id"
    t.index ["race_id"], name: "index_prizes_on_race_id"
    t.index ["user_id"], name: "index_prizes_on_user_id"
  end

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
    t.integer "moving_time"
    t.datetime "start_date_local"
    t.integer "race_id"
    t.bigint "race_try_id"
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
    t.integer "user_id"
    t.string "activity_type"
    t.string "name"
    t.float "distance"
    t.float "average_grade"
    t.float "maximum_grade"
    t.float "elevation_high"
    t.float "elevation_low"
    t.string "start_latlng", array: true
    t.string "end_latlng", array: true
    t.jsonb "all_data"
    t.decimal "price", precision: 8, scale: 2, default: "0.0"
  end

  create_table "registrations", force: :cascade do |t|
    t.bigint "race_id", null: false
    t.bigint "user_id", null: false
    t.string "status", default: "require_agreements"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "payment_status", default: "unpaid"
    t.boolean "agreements_signed", default: false
    t.string "session_id"
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
    t.integer "role", default: 3
    t.string "stripe_customer_id"
    t.string "gender"
    t.string "phone"
    t.boolean "profile_complete", default: false
    t.date "birthdate"
    t.boolean "is_subscribed", default: false
    t.string "stripe_conn_acc_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "prizes", "races"
  add_foreign_key "prizes", "users"
  add_foreign_key "race_categories", "races"
  add_foreign_key "race_tries", "registrations"
  add_foreign_key "race_tries", "users"
  add_foreign_key "registrations", "races"
  add_foreign_key "registrations", "users"
end
