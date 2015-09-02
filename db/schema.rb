# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150902110418) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string   "commenter"
    t.text     "body"
    t.integer  "article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["article_id"], name: "index_comments_on_article_id", using: :btree

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "playerships", force: :cascade do |t|
    t.string   "player"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ranks", primary_key: "rank_id", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sciences", force: :cascade do |t|
    t.integer  "science_id"
    t.integer  "cost1"
    t.integer  "cost2"
    t.integer  "cost3"
    t.float    "factor"
    t.time     "duration"
    t.string   "condition"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spaceships", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.float    "velocity"
    t.float    "capacity"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.float    "fuel"
  end

  create_table "stations", force: :cascade do |t|
    t.integer  "ID"
    t.integer  "typID"
    t.integer  "level"
    t.integer  "costMineral"
    t.integer  "costCristal"
    t.integer  "costFuel"
    t.integer  "energyUse"
    t.integer  "productionMineral"
    t.integer  "productionCristal"
    t.integer  "productionFuel"
    t.integer  "storageMineral"
    t.integer  "storageCristal"
    t.integer  "storageFuel"
    t.integer  "fuelUse"
    t.integer  "buildTime"
    t.integer  "tier"
    t.datetime "lastUpdate"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "test_tables", force: :cascade do |t|
    t.integer  "probe"
    t.integer  "spy_level_a"
    t.integer  "spy_level_d"
    t.integer  "emp_ship_a"
    t.integer  "emp_ship_d"
    t.integer  "ship_a"
    t.integer  "ship_d"
    t.float    "ship_a_damage"
    t.float    "ship_d_damage"
    t.float    "ship_a_hitpoints"
    t.float    "ship_d_hitpoints"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "users", id: false, force: :cascade do |t|
    t.text     "email"
    t.text     "encrypted_password"
    t.text     "reset_password_token"
    t.datetime "reset_password_send_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.text     "current_sign_in_ip"
    t.text     "last_sign_in_ip"
  end

  add_foreign_key "comments", "articles"
end
