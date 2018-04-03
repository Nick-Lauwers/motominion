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

ActiveRecord::Schema.define(version: 20180228014601) do

  create_table "answers", force: :cascade do |t|
    t.text     "content"
    t.integer  "likes"
    t.integer  "user_id"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["question_id", "created_at"], name: "index_answers_on_question_id_and_created_at"
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "appointments", force: :cascade do |t|
    t.string   "status"
    t.datetime "date"
    t.integer  "seller_id"
    t.integer  "buyer_id"
    t.integer  "vehicle_id"
    t.integer  "conversation_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["buyer_id", "date"], name: "index_appointments_on_buyer_id_and_date"
    t.index ["conversation_id"], name: "index_appointments_on_conversation_id"
    t.index ["vehicle_id"], name: "index_appointments_on_vehicle_id"
  end

  create_table "autopart_photos", force: :cascade do |t|
    t.integer  "autopart_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.index ["autopart_id"], name: "index_autopart_photos_on_autopart_id"
  end

  create_table "autoparts", force: :cascade do |t|
    t.string   "listing_name"
    t.string   "street_address"
    t.string   "apartment"
    t.string   "city"
    t.string   "state"
    t.integer  "price"
    t.text     "summary"
    t.text     "shipping_info"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "bumped_at"
    t.datetime "sold_at"
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["user_id", "created_at"], name: "index_autoparts_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_autoparts_on_user_id"
  end

  create_table "availabilities", force: :cascade do |t|
    t.string   "day"
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "vehicle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vehicle_id"], name: "index_availabilities_on_vehicle_id"
  end

  create_table "blogs", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "cover_photo_file_name"
    t.string   "cover_photo_content_type"
    t.integer  "cover_photo_file_size"
    t.datetime "cover_photo_updated_at"
    t.index ["user_id"], name: "index_blogs_on_user_id"
  end

  create_table "business_hours", force: :cascade do |t|
    t.string   "day"
    t.time     "open_time"
    t.time     "close_time"
    t.boolean  "is_closed"
    t.integer  "dealership_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["dealership_id"], name: "index_business_hours_on_dealership_id"
  end

  create_table "club_product_photos", force: :cascade do |t|
    t.integer  "club_product_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.index ["club_product_id"], name: "index_club_product_photos_on_club_product_id"
  end

  create_table "club_products", force: :cascade do |t|
    t.string   "name"
    t.integer  "price"
    t.text     "description"
    t.text     "shipping_info"
    t.integer  "club_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["club_id"], name: "index_club_products_on_club_id"
  end

  create_table "clubs", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "cover_photo_file_name"
    t.string   "cover_photo_content_type"
    t.integer  "cover_photo_file_size"
    t.datetime "cover_photo_updated_at"
    t.string   "city"
    t.string   "state"
    t.float    "latitude"
    t.float    "longitude"
  end

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

  create_table "dealer_invitations", force: :cascade do |t|
    t.string   "email"
    t.integer  "sender_id"
    t.integer  "dealership_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["dealership_id", "created_at"], name: "index_dealer_invitations_on_dealership_id_and_created_at"
    t.index ["sender_id", "created_at"], name: "index_dealer_invitations_on_sender_id_and_created_at"
  end

  create_table "dealerships", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "user_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "activation_digest"
    t.boolean  "activated",          default: false
    t.datetime "activated_at"
    t.string   "description"
    t.string   "website"
    t.string   "sales_phone"
    t.string   "service_phone"
    t.string   "street_address"
    t.string   "building"
    t.string   "city"
    t.string   "state"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.index ["user_id"], name: "index_dealerships_on_user_id"
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
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "discussion_comments", force: :cascade do |t|
    t.text     "comment"
    t.integer  "discussion_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["discussion_id", "created_at"], name: "index_discussion_comments_on_discussion_id_and_created_at"
    t.index ["discussion_id"], name: "index_discussion_comments_on_discussion_id"
    t.index ["user_id"], name: "index_discussion_comments_on_user_id"
  end

  create_table "discussions", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "club_id"
    t.integer  "vehicle_make_id"
    t.integer  "vehicle_model_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "cached_votes_up",  default: 0
    t.index ["cached_votes_up"], name: "index_discussions_on_cached_votes_up"
    t.index ["club_id", "created_at"], name: "index_discussions_on_club_id_and_created_at"
    t.index ["club_id"], name: "index_discussions_on_club_id"
    t.index ["user_id", "created_at"], name: "index_discussions_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_discussions_on_user_id"
    t.index ["vehicle_make_id", "created_at"], name: "index_discussions_on_vehicle_make_id_and_created_at"
    t.index ["vehicle_make_id"], name: "index_discussions_on_vehicle_make_id"
    t.index ["vehicle_model_id", "created_at"], name: "index_discussions_on_vehicle_model_id_and_created_at"
    t.index ["vehicle_model_id"], name: "index_discussions_on_vehicle_model_id"
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

  create_table "favorite_autoparts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "autopart_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id", "autopart_id"], name: "index_favorite_autoparts_on_user_id_and_autopart_id", unique: true
    t.index ["user_id", "created_at"], name: "index_favorite_autoparts_on_user_id_and_created_at"
  end

  create_table "favorite_vehicles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "vehicle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "created_at"], name: "index_favorite_vehicles_on_user_id_and_created_at"
    t.index ["user_id", "vehicle_id"], name: "index_favorite_vehicles_on_user_id_and_vehicle_id", unique: true
  end

  create_table "inquiries", force: :cascade do |t|
    t.datetime "date"
    t.integer  "user_id"
    t.integer  "vehicle_id"
    t.integer  "conversation_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["conversation_id"], name: "index_inquiries_on_conversation_id"
    t.index ["user_id", "date"], name: "index_inquiries_on_user_id_and_date"
    t.index ["user_id"], name: "index_inquiries_on_user_id"
    t.index ["vehicle_id"], name: "index_inquiries_on_vehicle_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.string   "email"
    t.string   "token"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.integer  "club_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["club_id", "created_at"], name: "index_invitations_on_club_id_and_created_at"
    t.index ["recipient_id", "created_at"], name: "index_invitations_on_recipient_id_and_created_at"
    t.index ["sender_id", "created_at"], name: "index_invitations_on_sender_id_and_created_at"
  end

  create_table "memberships", force: :cascade do |t|
    t.boolean  "admin"
    t.integer  "user_id"
    t.integer  "club_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "club_id"], name: "index_memberships_on_user_id_and_club_id", unique: true
    t.index ["user_id", "created_at"], name: "index_memberships_on_user_id_and_created_at"
  end

  create_table "message_photos", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "messages", force: :cascade do |t|
    t.text     "content"
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.boolean  "received"
    t.integer  "user_id"
    t.integer  "vehicle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_payments_on_user_id"
    t.index ["vehicle_id", "created_at"], name: "index_payments_on_vehicle_id_and_created_at"
    t.index ["vehicle_id"], name: "index_payments_on_vehicle_id"
  end

  create_table "photos", force: :cascade do |t|
    t.integer  "vehicle_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "rotation",           default: 0, null: false
    t.index ["vehicle_id"], name: "index_photos_on_vehicle_id"
  end

  create_table "post_comments", force: :cascade do |t|
    t.string   "content"
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id", "created_at"], name: "index_post_comments_on_post_id_and_created_at"
    t.index ["post_id"], name: "index_post_comments_on_post_id"
    t.index ["user_id"], name: "index_post_comments_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "club_id"
    t.integer  "vehicle_make_id"
    t.integer  "vehicle_model_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "cached_votes_up",    default: 0
    t.string   "video_url"
    t.index ["cached_votes_up"], name: "index_posts_on_cached_votes_up"
    t.index ["club_id", "created_at"], name: "index_posts_on_club_id_and_created_at"
    t.index ["club_id"], name: "index_posts_on_club_id"
    t.index ["user_id", "created_at"], name: "index_posts_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_posts_on_user_id"
    t.index ["vehicle_make_id", "created_at"], name: "index_posts_on_vehicle_make_id_and_created_at"
    t.index ["vehicle_make_id"], name: "index_posts_on_vehicle_make_id"
    t.index ["vehicle_model_id", "created_at"], name: "index_posts_on_vehicle_model_id_and_created_at"
    t.index ["vehicle_model_id"], name: "index_posts_on_vehicle_model_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone_number"
    t.string   "billing_first_name"
    t.string   "billing_last_name"
    t.string   "billing_street_address"
    t.string   "billing_apartment"
    t.string   "billing_city"
    t.string   "billing_state"
    t.string   "education"
    t.string   "employment"
    t.string   "employer_name"
    t.string   "employer_phone"
    t.string   "current_title"
    t.string   "residence_type"
    t.integer  "annual_income"
    t.integer  "time_at_job"
    t.integer  "monthly_payment"
    t.integer  "time_at_address"
    t.boolean  "is_extended_service_contract"
    t.boolean  "is_wheel_tire_care"
    t.boolean  "is_ding_dent_care"
    t.boolean  "is_key_replacement"
    t.boolean  "is_resistall_protection"
    t.datetime "date_of_birth"
    t.datetime "processed_at"
    t.integer  "buyer_id"
    t.integer  "seller_id"
    t.integer  "vehicle_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["buyer_id", "created_at"], name: "index_purchases_on_buyer_id_and_created_at"
    t.index ["seller_id", "created_at"], name: "index_purchases_on_seller_id_and_created_at"
    t.index ["vehicle_id"], name: "index_purchases_on_vehicle_id"
  end

  create_table "purchases_upgrades", id: false, force: :cascade do |t|
    t.integer "upgrade_id",  null: false
    t.integer "purchase_id", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.text     "content"
    t.integer  "likes"
    t.datetime "read_at"
    t.integer  "user_id"
    t.integer  "vehicle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_questions_on_user_id"
    t.index ["vehicle_id", "created_at"], name: "index_questions_on_vehicle_id_and_created_at"
    t.index ["vehicle_id"], name: "index_questions_on_vehicle_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string   "title"
    t.text     "comment"
    t.integer  "rating"
    t.integer  "reviewer_id"
    t.integer  "reviewed_id"
    t.integer  "vehicle_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.datetime "read_at"
    t.integer  "dealership_id"
    t.index ["dealership_id", "created_at"], name: "index_reviews_on_dealership_id_and_created_at"
    t.index ["dealership_id"], name: "index_reviews_on_dealership_id"
    t.index ["reviewed_id", "created_at"], name: "index_reviews_on_reviewed_id_and_created_at"
    t.index ["reviewer_id", "created_at"], name: "index_reviews_on_reviewer_id_and_created_at"
    t.index ["vehicle_id", "created_at"], name: "index_reviews_on_vehicle_id_and_created_at"
  end

  create_table "upgrades", force: :cascade do |t|
    t.string   "title"
    t.integer  "duration"
    t.integer  "price"
    t.integer  "vehicle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vehicle_id"], name: "index_upgrades_on_vehicle_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
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
    t.string   "stripe_id"
    t.string   "merchant_id"
    t.integer  "dealership_id"
    t.boolean  "dealership_admin",    default: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "vehicle_makes", force: :cascade do |t|
    t.string   "name"
    t.string   "cover_photo_url"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "vehicle_models", force: :cascade do |t|
    t.string   "name"
    t.integer  "vehicle_make_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["vehicle_make_id"], name: "index_vehicle_models_on_vehicle_make_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.string   "body_style"
    t.string   "color"
    t.string   "engine_type"
    t.string   "fuel_type"
    t.string   "vin"
    t.string   "listing_name"
    t.string   "street_address"
    t.string   "apartment"
    t.string   "city"
    t.string   "state"
    t.integer  "year"
    t.integer  "price"
    t.integer  "mileage"
    t.integer  "engine_size"
    t.text     "summary"
    t.text     "sellers_notes"
    t.boolean  "is_cruise_control"
    t.boolean  "is_am_fm"
    t.boolean  "is_cb_radio"
    t.boolean  "is_navigation_system"
    t.boolean  "is_heated_seats"
    t.boolean  "is_heated_hand_grips"
    t.boolean  "is_alarm_system"
    t.boolean  "is_saddlebags"
    t.boolean  "is_trunk"
    t.boolean  "is_tow_hitch"
    t.boolean  "is_cycle_cover"
    t.integer  "user_id"
    t.integer  "vehicle_make_id"
    t.integer  "vehicle_model_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "sold_at"
    t.datetime "bumped_at"
    t.datetime "posted_at"
    t.integer  "dealership_id"
    t.index ["dealership_id", "created_at"], name: "index_vehicles_on_dealership_id_and_created_at"
    t.index ["dealership_id"], name: "index_vehicles_on_dealership_id"
    t.index ["user_id", "created_at"], name: "index_vehicles_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_vehicles_on_user_id"
    t.index ["vehicle_make_id"], name: "index_vehicles_on_vehicle_make_id"
    t.index ["vehicle_model_id"], name: "index_vehicles_on_vehicle_model_id"
  end

  create_table "votes", force: :cascade do |t|
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.string   "votable_type"
    t.integer  "votable_id"
    t.string   "voter_type"
    t.integer  "voter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
  end

end
