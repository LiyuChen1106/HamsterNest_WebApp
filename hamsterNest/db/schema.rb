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

ActiveRecord::Schema.define(version: 2018_10_09_045144) do

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
    t.integer "owner_id"
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_items_on_category_id"
    t.index ["owner_id"], name: "index_items_on_owner_id"
  end

  create_table "user_accounts", primary_key: "email", id: :string, force: :cascade do |t|
    t.string "password"
    t.string "salt"
    t.integer "username_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username_id"], name: "index_user_accounts_on_username_id"
  end

  create_table "user_details", primary_key: "username", id: :string, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.date "birthday"
    t.integer "lend_rating"
    t.integer "borrow_rating"
    t.integer "items_list_id"
    t.integer "friends_list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friends_list_id"], name: "index_user_details_on_friends_list_id"
    t.index ["items_list_id"], name: "index_user_details_on_items_list_id"
  end

end