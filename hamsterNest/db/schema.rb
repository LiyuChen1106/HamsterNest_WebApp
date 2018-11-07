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

ActiveRecord::Schema.define(version: 2018_10_17_012144) do

  create_table "borrow_requests", force: :cascade do |t|
    t.integer "item_id", null: false
    t.integer "user_profile_id", null: false
    t.boolean "approval", default: false
    t.date "borrow_date", null: false
    t.date "return_date", null: false
    t.string "request_message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_borrow_requests_on_item_id"
    t.index ["user_profile_id"], name: "index_borrow_requests_on_user_profile_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "category_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "histories", force: :cascade do |t|
    t.integer "item_id"
    t.integer "borrower_id"
    t.date "lend_date"
    t.date "return_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["borrower_id"], name: "index_histories_on_borrower_id"
    t.index ["item_id"], name: "index_histories_on_item_id"
  end

  create_table "items", force: :cascade do |t|
    t.integer "category_id"
    t.string "item_name"
    t.integer "user_profile_id"
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_items_on_category_id"
    t.index ["user_profile_id"], name: "index_items_on_user_profile_id"
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
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["user_profile_id"], name: "index_users_on_user_profile_id"
  end

end
