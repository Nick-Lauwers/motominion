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

ActiveRecord::Schema.define(version: 20161213004644) do

  create_table "appointments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "vehicle_id"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "appointments", ["user_id", "date"], name: "index_appointments_on_user_id_and_date"
  add_index "appointments", ["user_id"], name: "index_appointments_on_user_id"
  add_index "appointments", ["vehicle_id"], name: "index_appointments_on_vehicle_id"

  create_table "comments", force: :cascade do |t|
    t.text     "title"
    t.text     "content"
    t.integer  "likes"
    t.integer  "user_id"
    t.integer  "vehicle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["user_id"], name: "index_comments_on_user_id"
  add_index "comments", ["vehicle_id", "created_at"], name: "index_comments_on_vehicle_id_and_created_at"
  add_index "comments", ["vehicle_id"], name: "index_comments_on_vehicle_id"

  create_table "conversations", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "enquiries", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone_number"
    t.string   "category"
    t.text     "content"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "favorite_vehicles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "vehicle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "favorite_vehicles", ["user_id", "created_at"], name: "index_favorite_vehicles_on_user_id_and_created_at"
  add_index "favorite_vehicles", ["user_id", "vehicle_id"], name: "index_favorite_vehicles_on_user_id_and_vehicle_id", unique: true

  create_table "messages", force: :cascade do |t|
    t.text     "content"
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id"
  add_index "messages", ["user_id"], name: "index_messages_on_user_id"

  create_table "payment_statuses", force: :cascade do |t|
    t.string   "action"
    t.string   "message"
    t.string   "authorization"
    t.text     "params"
    t.integer  "amount"
    t.boolean  "success"
    t.integer  "payment_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "payment_statuses", ["payment_id"], name: "index_payment_statuses_on_payment_id"

  create_table "payments", force: :cascade do |t|
    t.string   "ip_address"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "card_type"
    t.date     "card_expiration"
    t.integer  "vehicle_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "payments", ["vehicle_id"], name: "index_payments_on_vehicle_id"

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

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "replies", force: :cascade do |t|
    t.text     "content"
    t.integer  "likes"
    t.integer  "user_id"
    t.integer  "comment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "replies", ["comment_id", "created_at"], name: "index_replies_on_comment_id_and_created_at"
  add_index "replies", ["comment_id"], name: "index_replies_on_comment_id"
  add_index "replies", ["user_id"], name: "index_replies_on_user_id"

  create_table "responses", force: :cascade do |t|
    t.text     "comment"
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "responses", ["post_id", "created_at"], name: "index_responses_on_post_id_and_created_at"
  add_index "responses", ["post_id"], name: "index_responses_on_post_id"
  add_index "responses", ["user_id"], name: "index_responses_on_user_id"

  create_table "reviews", force: :cascade do |t|
    t.string   "title"
    t.text     "comment"
    t.integer  "rating"
    t.integer  "vehicle_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id"
  add_index "reviews", ["vehicle_id"], name: "index_reviews_on_vehicle_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "is_subscribed"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",               default: false
    t.string   "activation_digest"
    t.boolean  "activated",           default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "phone_number"
    t.string   "residence"
    t.string   "school"
    t.string   "work"
    t.text     "description"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "vehicles", force: :cascade do |t|
    t.string   "vehicle_condition"
    t.string   "body_style"
    t.string   "color"
    t.string   "transmission"
    t.string   "fuel_type"
    t.string   "drivetrain"
    t.string   "vin"
    t.string   "listing_name"
    t.string   "address"
    t.integer  "year"
    t.integer  "price"
    t.integer  "mileage"
    t.integer  "seating_capacity"
    t.text     "summary"
    t.text     "sellers_notes"
    t.boolean  "is_leather_seats"
    t.boolean  "is_sunroof"
    t.boolean  "is_navigation_system"
    t.boolean  "is_dvd_entertainment_system"
    t.boolean  "is_bluetooth"
    t.boolean  "is_backup_camera"
    t.boolean  "is_remote_start"
    t.boolean  "is_tow_package"
    t.boolean  "is_autonomy"
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "vehicles", ["user_id", "created_at"], name: "index_vehicles_on_user_id_and_created_at"
  add_index "vehicles", ["user_id"], name: "index_vehicles_on_user_id"

end
