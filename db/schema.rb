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

ActiveRecord::Schema.define(version: 20150903141505) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"


  create_table "fighting_fleets", force: :cascade do |t|
    t.float    "shield"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  add_index "fighting_fleets", ["user_id"], name: "index_fighting_fleets_on_user_id", using: :btree

  create_table "fights", force: :cascade do |t|
    t.text     "report"
    t.datetime "time"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "attacker_id"
    t.integer  "defender_id"
  end

  add_index "fights", ["defender_id"], name: "index_fights_on_defender_id", using: :btree

  create_table "menus", force: :cascade do |t|
    t.string   "title"
    t.string   "link"
    t.string   "image"
    t.integer  "index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ranks", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "science_instances", force: :cascade do |t|
    t.integer  "science_id"
    t.integer  "user_id"
    t.integer  "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sciences", force: :cascade do |t|
    t.integer  "cost1"
    t.integer  "cost2"
    t.integer  "cost3"
    t.float    "factor"
    t.time     "duration"
    t.string   "condition"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "ship_groups", force: :cascade do |t|
    t.integer  "fighting_fleet_id"
    t.integer  "ship_id"
    t.integer  "number"
    t.float    "group_hitpoints"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "ship_groups", ["fighting_fleet_id"], name: "index_ship_groups_on_fighting_fleet_id", using: :btree
  add_index "ship_groups", ["ship_id"], name: "index_ship_groups_on_ship_id", using: :btree

  create_table "ships", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ships_stations", force: :cascade do |t|
    t.integer  "ship_id"
    t.integer  "station_id"
    t.integer  "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "ships_stations", ["ship_id"], name: "index_ships_stations_on_ship_id", using: :btree
  add_index "ships_stations", ["station_id"], name: "index_ships_stations_on_station_id", using: :btree

  create_table "stations", force: :cascade do |t|
    t.text     "name"
    t.integer  "costMIneral"
    t.integer  "costCristal"
    t.integer  "costFuel"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "fighting_fleets", "users"
  add_foreign_key "ship_groups", "fighting_fleets"
  add_foreign_key "ship_groups", "ships"
end
