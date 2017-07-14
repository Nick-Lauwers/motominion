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

ActiveRecord::Schema.define(version: 20170713113429) do

  create_table "appointments", force: :cascade do |t|
    t.string   "status"
    t.datetime "date"
    t.integer  "seller_id"
    t.integer  "buyer_id"
    t.integer  "vehicle_id"
    t.integer  "conversation_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "appointments", ["buyer_id", "date"], name: "index_appointments_on_buyer_id_and_date"
  add_index "appointments", ["conversation_id"], name: "index_appointments_on_conversation_id"
  add_index "appointments", ["vehicle_id"], name: "index_appointments_on_vehicle_id"

  create_table "availabilities", force: :cascade do |t|
    t.string   "day"
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "vehicle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "availabilities", ["vehicle_id"], name: "index_availabilities_on_vehicle_id"

  create_table "conversations", force: :cascade do |t|
    t.integer  "next_contributor_id"
    t.boolean  "latest_message_read"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.boolean  "sender_archived"
    t.boolean  "recipient_archived"
    t.datetime "sender_last_viewed_at"
    t.datetime "recipient_last_viewed_at"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

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

  create_table "inquiries", force: :cascade do |t|
    t.datetime "date"
    t.integer  "user_id"
    t.integer  "vehicle_id"
    t.integer  "conversation_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "inquiries", ["conversation_id"], name: "index_inquiries_on_conversation_id"
  add_index "inquiries", ["user_id", "date"], name: "index_inquiries_on_user_id_and_date"
  add_index "inquiries", ["user_id"], name: "index_inquiries_on_user_id"
  add_index "inquiries", ["vehicle_id"], name: "index_inquiries_on_vehicle_id"

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
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "rotation",           default: 0, null: false
  end

  add_index "photos", ["vehicle_id"], name: "index_photos_on_vehicle_id"

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "cached_votes_up", default: 0
  end

  add_index "posts", ["cached_votes_up"], name: "index_posts_on_cached_votes_up"
  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "questions", force: :cascade do |t|
    t.text     "content"
    t.integer  "likes"
    t.datetime "read_at"
    t.integer  "user_id"
    t.integer  "vehicle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "questions", ["user_id"], name: "index_questions_on_user_id"
  add_index "questions", ["vehicle_id", "created_at"], name: "index_questions_on_vehicle_id_and_created_at"
  add_index "questions", ["vehicle_id"], name: "index_questions_on_vehicle_id"

  create_table "replies", force: :cascade do |t|
    t.text     "content"
    t.integer  "likes"
    t.integer  "user_id"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "replies", ["question_id", "created_at"], name: "index_replies_on_question_id_and_created_at"
  add_index "replies", ["question_id"], name: "index_replies_on_question_id"
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
    t.integer  "reviewer_id"
    t.integer  "reviewed_id"
    t.integer  "vehicle_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "read_at"
  end

  add_index "reviews", ["reviewed_id", "created_at"], name: "index_reviews_on_reviewed_id_and_created_at"
  add_index "reviews", ["reviewer_id", "created_at"], name: "index_reviews_on_reviewer_id_and_created_at"
  add_index "reviews", ["vehicle_id", "created_at"], name: "index_reviews_on_vehicle_id_and_created_at"

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

  create_table "vehicle_makes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vehicle_models", force: :cascade do |t|
    t.string   "name"
    t.integer  "vehicle_make_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "vehicle_models", ["vehicle_make_id"], name: "index_vehicle_models_on_vehicle_make_id"

  create_table "vehicles", force: :cascade do |t|
    t.string   "body_style"
    t.string   "color"
    t.string   "transmission"
    t.string   "fuel_type"
    t.string   "drivetrain"
    t.string   "vin"
    t.string   "listing_name"
    t.string   "street_address"
    t.string   "apartment"
    t.string   "city"
    t.string   "state"
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
    t.integer  "user_id"
    t.integer  "vehicle_make_id"
    t.integer  "vehicle_model_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "sold_at"
    t.datetime "bumped_at"
  end

  add_index "vehicles", ["user_id", "created_at"], name: "index_vehicles_on_user_id_and_created_at"
  add_index "vehicles", ["user_id"], name: "index_vehicles_on_user_id"
  add_index "vehicles", ["vehicle_make_id"], name: "index_vehicles_on_vehicle_make_id"
  add_index "vehicles", ["vehicle_model_id"], name: "index_vehicles_on_vehicle_model_id"

  create_table "votes", force: :cascade do |t|
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"

end
