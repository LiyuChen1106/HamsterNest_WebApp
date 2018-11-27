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

ActiveRecord::Schema.define(version: 2018_11_27_212927) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "borrow_requests", force: :cascade do |t|
    t.integer "item_id", null: false
    t.integer "user_profile_id", null: false
    t.boolean "approval"
    t.date "borrow_date", null: false
    t.date "return_date", null: false
    t.string "request_message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity", default: 1
    t.boolean "read_status", default: false
    t.integer "return_status", default: 0
    t.date "actual_return_date"
    t.date "actual_borrow_date"
    t.index ["item_id"], name: "index_borrow_requests_on_item_id"
    t.index ["user_profile_id"], name: "index_borrow_requests_on_user_profile_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "category_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "user_profile_id", null: false
    t.date "comment_date", null: false
    t.string "comment_message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_comments_on_item_id"
    t.index ["user_profile_id"], name: "index_comments_on_user_profile_id"
  end

  create_table "items", force: :cascade do |t|
    t.integer "category_id"
    t.string "item_name"
    t.integer "user_profile_id"
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "left_quantity"
    t.integer "quantity", default: 1
    t.string "description"
    t.index ["category_id"], name: "index_items_on_category_id"
    t.index ["user_profile_id"], name: "index_items_on_user_profile_id"
  end

  create_table "provinces", force: :cascade do |t|
    t.string "province"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_profiles", force: :cascade do |t|
    t.integer "user_id"
    t.string "username", null: false
    t.string "first_name"
    t.string "last_name"
    t.date "birthday"
    t.integer "lend_rating"
    t.integer "borrow_rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.hstore "address"
    t.float "latitude"
    t.float "longitude"
    t.integer "lpeople", default: 0
    t.integer "bpeople", default: 0
    t.index ["user_id"], name: "index_user_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.integer "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "user_profile_id"
    t.boolean "superadmin_role", default: false
    t.boolean "supervisor_role", default: false
    t.boolean "user_role", default: true
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["user_profile_id"], name: "index_users_on_user_profile_id"
  end

  add_foreign_key "comments", "items"
  add_foreign_key "comments", "user_profiles"
end
