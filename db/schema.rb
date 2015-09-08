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

ActiveRecord::Schema.define(version: 20150907135923) do

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

  create_table "damage_types", force: :cascade do |t|
    t.string   "name"
    t.float    "shell_mult"
    t.float    "shield_mult"
    t.float    "station_mult"
    t.float    "plattform_mult"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "example2s", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "example2s", ["user_id"], name: "index_example2s_on_user_id", using: :btree

  create_table "examples", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "examples", ["user_id"], name: "index_examples_on_user_id", using: :btree

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
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "attacker_id"
    t.integer  "defender_id"
    t.time     "time"
  end

  add_index "fights", ["attacker_id"], name: "index_fights_on_attacker_id", using: :btree
  add_index "fights", ["defender_id"], name: "index_fights_on_defender_id", using: :btree

  create_table "menus", force: :cascade do |t|
    t.string   "title"
    t.string   "link"
    t.string   "image"
    t.integer  "index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text     "mes"
    t.integer  "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "message_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "notifications", ["message_id"], name: "index_notifications_on_message_id", using: :btree
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "ranks", force: :cascade do |t|
    t.integer  "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resources", force: :cascade do |t|
    t.text     "name"
    t.integer  "production"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "science_instances", force: :cascade do |t|
    t.integer  "science_id"
    t.integer  "user_id"
    t.integer  "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.time     "start_time"
  end

  create_table "sciences", force: :cascade do |t|
    t.integer  "science_id"
    t.integer  "cost1"
    t.integer  "cost2"
    t.integer  "cost3"
    t.float    "factor"
    t.integer  "duration"
    t.string   "condition"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "name"
    t.integer  "tier"
    t.integer  "science_condition_id"
    t.string   "icon"
 end

  create_table "ships", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "metal"
    t.integer  "cristal"
    t.integer  "fuel"
    t.datetime "lastChecked"
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
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "initial_level"
    t.text     "description"
    t.integer  "condition"
    t.integer  "tier"
    t.string   "icons"
  end

  create_table "teaparties", force: :cascade do |t|
    t.string   "name"
    t.integer  "price"
    t.text     "report"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "units", force: :cascade do |t|
    t.string   "name"
    t.integer  "metal_price"
    t.integer  "crystal_price"
    t.integer  "fuel_price"
    t.integer  "total_cost"
    t.integer  "shell"
    t.integer  "damage"
    t.integer  "damage_type_id"
    t.integer  "cargo"
    t.integer  "speed"
    t.integer  "shipyard_requirement"
    t.integer  "research_requirement_one"
    t.integer  "research_requiement_two"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "units", ["damage_type_id"], name: "index_units_on_damage_type_id", using: :btree

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
    t.integer  "right_level"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "example2s", "users"
  add_foreign_key "examples", "users"
  add_foreign_key "fighting_fleets", "users"
  add_foreign_key "notifications", "messages"
  add_foreign_key "notifications", "users"
  add_foreign_key "ship_groups", "fighting_fleets"
  add_foreign_key "ship_groups", "ships"
  add_foreign_key "units", "damage_types"
end
