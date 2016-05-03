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

ActiveRecord::Schema.define(version: 20160502122109) do

  create_table "appointments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "vehicle_id"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "appointments", ["user_id"], name: "index_appointments_on_user_id"
  add_index "appointments", ["vehicle_id"], name: "index_appointments_on_vehicle_id"

  create_table "photos", force: :cascade do |t|
    t.integer  "vehicle_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "photos", ["vehicle_id"], name: "index_photos_on_vehicle_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "vehicles", force: :cascade do |t|
    t.string   "body_style"
    t.integer  "passenger_capacity"
    t.string   "exterior_color"
    t.string   "interior_color"
    t.string   "wheel"
    t.string   "tire"
    t.string   "fuel_type"
    t.string   "engine"
    t.string   "transmission"
    t.string   "vin"
    t.string   "listing_name"
    t.text     "summary"
    t.string   "address"
    t.integer  "price"
    t.boolean  "active"
    t.integer  "user_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "vehicles", ["user_id", "created_at"], name: "index_vehicles_on_user_id_and_created_at"
  add_index "vehicles", ["user_id"], name: "index_vehicles_on_user_id"

end
