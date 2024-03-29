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

ActiveRecord::Schema[7.0].define(version: 2023_03_18_110125) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
  end

  create_table "articles", force: :cascade do |t|
    t.bigint "service_id", null: false
    t.string "title"
    t.text "video_tag"
    t.text "content"
    t.integer "year"
    t.integer "month"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id"], name: "index_articles_on_service_id"
  end

  create_table "password_resets", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "token"
    t.datetime "sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_password_resets_on_user_id"
  end

  create_table "registering_user_passwords", force: :cascade do |t|
    t.bigint "registering_user_id", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["registering_user_id"], name: "index_registering_user_passwords_on_registering_user_id"
  end

  create_table "registering_user_tokens", force: :cascade do |t|
    t.bigint "registering_user_id", null: false
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["registering_user_id"], name: "index_registering_user_tokens_on_registering_user_id"
    t.index ["token"], name: "index_registering_user_tokens_on_token", unique: true
  end

  create_table "registering_users", force: :cascade do |t|
    t.string "email", limit: 254, null: false
    t.string "nickname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "name_kana"
    t.string "phone_number"
    t.string "zipcode"
    t.integer "prefecture_id"
    t.string "address"
    t.date "birthday"
    t.index ["email"], name: "index_registering_users_on_email", unique: true
  end

  create_table "service_stripes", force: :cascade do |t|
    t.bigint "service_id", null: false
    t.string "stripe_price_identifier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id"], name: "index_service_stripes_on_service_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stripe_sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "session_identifier"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_stripe_sessions_on_user_id"
  end

  create_table "subscription_stripes", force: :cascade do |t|
    t.bigint "subscription_id", null: false
    t.string "stripe_customer_identifier"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subscription_id"], name: "index_subscription_stripes_on_subscription_id"
  end

  create_table "subscription_valid_periods", force: :cascade do |t|
    t.bigint "subscription_id", null: false
    t.datetime "starts_at"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subscription_id"], name: "index_subscription_valid_periods_on_subscription_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "service_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id"], name: "index_subscriptions_on_service_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "user_password_authentications", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_password_authentications_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "nickname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "name_kana"
    t.string "phone_number"
    t.string "zipcode"
    t.integer "prefecture_id"
    t.string "address"
    t.date "birthday"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "articles", "services"
  add_foreign_key "password_resets", "users"
  add_foreign_key "registering_user_passwords", "registering_users"
  add_foreign_key "registering_user_tokens", "registering_users"
  add_foreign_key "service_stripes", "services"
  add_foreign_key "stripe_sessions", "users"
  add_foreign_key "subscription_stripes", "subscriptions"
  add_foreign_key "subscription_valid_periods", "subscriptions"
  add_foreign_key "subscriptions", "services"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "user_password_authentications", "users"
end
