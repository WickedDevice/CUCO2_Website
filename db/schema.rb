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

ActiveRecord::Schema.define(version: 20140701125820) do

  create_table "device_experiments", force: true do |t|
    t.integer  "device_id"
    t.integer  "experiment_id"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "devices", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "experiment_id"
    t.integer  "user_id"
    t.string   "encryption_key"
  end

  add_index "devices", ["address"], name: "index_devices_on_address", unique: true

  create_table "experiments", force: true do |t|
    t.string   "name"
    t.string   "location"
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "co2_cutoff"
    t.integer  "user_id"
    t.text     "details"
  end

  create_table "pages", force: true do |t|
    t.string   "long_title"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["title"], name: "index_pages_on_title", unique: true

  create_table "sensor_data", force: true do |t|
    t.integer  "ppm"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "device_id"
    t.integer  "experiment_id"
  end

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "password_digest"
    t.boolean  "admin"
  end

  add_index "users", ["name"], name: "index_users_on_name", unique: true

end
