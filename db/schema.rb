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

ActiveRecord::Schema[7.0].define(version: 2024_12_08_185636) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accessories", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.string "gender"
    t.decimal "price"
    t.decimal "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_accessories_on_user_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.string "apartment_no"
    t.string "street_address"
    t.string "city"
    t.string "state"
    t.string "pin_code"
    t.string "address_type"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "answers", force: :cascade do |t|
    t.bigint "faq_id", null: false
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["faq_id"], name: "index_answers_on_faq_id"
  end

  create_table "cart_items", force: :cascade do |t|
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "cart_id", null: false
    t.integer "tortoise_id"
    t.decimal "price", precision: 10, scale: 2
    t.bigint "accessory_id"
    t.index ["accessory_id"], name: "index_cart_items_on_accessory_id"
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "chat_participations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "chat_session_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_session_id"], name: "index_chat_participations_on_chat_session_id"
    t.index ["user_id"], name: "index_chat_participations_on_user_id"
  end

  create_table "chat_sessions", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "profile_id", null: false
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_comments_on_profile_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "faqs", force: :cascade do |t|
    t.string "question"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_faqs_on_user_id"
  end

  create_table "follows", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "profile_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_follows_on_profile_id"
    t.index ["user_id"], name: "index_follows_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "profile_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_likes_on_profile_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.bigint "chat_session_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_session_id"], name: "index_messages_on_chat_session_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.string "item_type"
    t.integer "item_id"
    t.integer "quantity"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "orderid"
    t.datetime "order_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.decimal "total_price", precision: 10, scale: 2
    t.string "discount_code"
    t.decimal "discounted_price"
    t.integer "status", default: 0
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "description"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating"
    t.text "comment"
    t.bigint "user_id", null: false
    t.bigint "tortoise_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "accessory_id"
    t.index ["accessory_id"], name: "index_reviews_on_accessory_id"
    t.index ["tortoise_id"], name: "index_reviews_on_tortoise_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "tortoises", force: :cascade do |t|
    t.string "name"
    t.string "species"
    t.string "gender"
    t.string "shell_pattern"
    t.string "shell_texture"
    t.string "elite_design"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.integer "quantity"
    t.index ["user_id"], name: "index_tortoises_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.string "card_holder_name"
    t.string "card_number"
    t.string "expiry_date"
    t.string "cvv"
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wishlists", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "tortoise_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "accessory_id"
    t.index ["accessory_id"], name: "index_wishlists_on_accessory_id"
    t.index ["tortoise_id"], name: "index_wishlists_on_tortoise_id"
    t.index ["user_id"], name: "index_wishlists_on_user_id"
  end

  add_foreign_key "accessories", "users"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "addresses", "users"
  add_foreign_key "answers", "faqs"
  add_foreign_key "cart_items", "accessories"
  add_foreign_key "cart_items", "carts"
  add_foreign_key "carts", "users"
  add_foreign_key "chat_participations", "chat_sessions"
  add_foreign_key "chat_participations", "users"
  add_foreign_key "comments", "profiles"
  add_foreign_key "comments", "users"
  add_foreign_key "faqs", "users"
  add_foreign_key "follows", "profiles"
  add_foreign_key "follows", "users"
  add_foreign_key "likes", "profiles"
  add_foreign_key "likes", "users"
  add_foreign_key "messages", "chat_sessions"
  add_foreign_key "messages", "users"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "reviews", "accessories"
  add_foreign_key "reviews", "tortoises"
  add_foreign_key "reviews", "users"
  add_foreign_key "tortoises", "users"
  add_foreign_key "wishlists", "accessories"
  add_foreign_key "wishlists", "tortoises"
  add_foreign_key "wishlists", "users"
end
