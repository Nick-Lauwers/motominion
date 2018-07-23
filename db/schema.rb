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

ActiveRecord::Schema.define(version: 20180719204120) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.text     "content"
    t.integer  "likes"
    t.integer  "user_id"
    t.integer  "question_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.boolean  "is_anonymous"
  end

  add_index "answers", ["question_id", "created_at"], name: "index_answers_on_question_id_and_created_at", using: :btree
  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree
  add_index "answers", ["user_id"], name: "index_answers_on_user_id", using: :btree

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

  add_index "appointments", ["buyer_id", "date"], name: "index_appointments_on_buyer_id_and_date", using: :btree
  add_index "appointments", ["conversation_id"], name: "index_appointments_on_conversation_id", using: :btree
  add_index "appointments", ["vehicle_id"], name: "index_appointments_on_vehicle_id", using: :btree

  create_table "autopart_photos", force: :cascade do |t|
    t.integer  "autopart_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "autopart_photos", ["autopart_id"], name: "index_autopart_photos_on_autopart_id", using: :btree

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
  end

  add_index "autoparts", ["user_id", "created_at"], name: "index_autoparts_on_user_id_and_created_at", using: :btree
  add_index "autoparts", ["user_id"], name: "index_autoparts_on_user_id", using: :btree

  create_table "availabilities", force: :cascade do |t|
    t.string   "day"
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "vehicle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "availabilities", ["vehicle_id"], name: "index_availabilities_on_vehicle_id", using: :btree

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
  end

  add_index "blogs", ["user_id"], name: "index_blogs_on_user_id", using: :btree

  create_table "business_hours", force: :cascade do |t|
    t.string   "day"
    t.time     "open_time"
    t.time     "close_time"
    t.boolean  "is_closed"
    t.integer  "dealership_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "business_hours", ["dealership_id"], name: "index_business_hours_on_dealership_id", using: :btree

  create_table "club_product_photos", force: :cascade do |t|
    t.integer  "club_product_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "club_product_photos", ["club_product_id"], name: "index_club_product_photos_on_club_product_id", using: :btree

  create_table "club_products", force: :cascade do |t|
    t.string   "name"
    t.integer  "price"
    t.text     "description"
    t.text     "shipping_info"
    t.integer  "club_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "club_products", ["club_id"], name: "index_club_products_on_club_id", using: :btree

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
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.boolean  "sender_archived"
    t.boolean  "recipient_archived"
    t.datetime "sender_last_viewed_at"
    t.datetime "recipient_last_viewed_at"
    t.boolean  "is_sender_anonymous",      default: true
  end

  create_table "dealer_invitations", force: :cascade do |t|
    t.string   "email"
    t.integer  "sender_id"
    t.integer  "dealership_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "dealer_invitations", ["dealership_id", "created_at"], name: "index_dealer_invitations_on_dealership_id_and_created_at", using: :btree
  add_index "dealer_invitations", ["sender_id", "created_at"], name: "index_dealer_invitations_on_sender_id_and_created_at", using: :btree

  create_table "dealerships", force: :cascade do |t|
    t.string   "dealership_name"
    t.string   "scrape_name"
    t.string   "email"
    t.integer  "user_id"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "activation_digest"
    t.boolean  "activated",                  default: false
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
    t.datetime "last_run_start_at"
    t.datetime "last_run_end_at"
    t.integer  "last_run_total_records"
    t.integer  "last_run_new_records"
    t.integer  "last_run_duplicate_records"
    t.integer  "last_run_error_records"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "scraped_id"
    t.string   "google_place_id"
  end

  add_index "dealerships", ["user_id"], name: "index_dealerships_on_user_id", using: :btree

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

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "discussion_comments", force: :cascade do |t|
    t.text     "comment"
    t.integer  "discussion_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "discussion_comments", ["discussion_id", "created_at"], name: "index_discussion_comments_on_discussion_id_and_created_at", using: :btree
  add_index "discussion_comments", ["discussion_id"], name: "index_discussion_comments_on_discussion_id", using: :btree
  add_index "discussion_comments", ["user_id"], name: "index_discussion_comments_on_user_id", using: :btree

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
  end

  add_index "discussions", ["cached_votes_up"], name: "index_discussions_on_cached_votes_up", using: :btree
  add_index "discussions", ["club_id", "created_at"], name: "index_discussions_on_club_id_and_created_at", using: :btree
  add_index "discussions", ["club_id"], name: "index_discussions_on_club_id", using: :btree
  add_index "discussions", ["user_id", "created_at"], name: "index_discussions_on_user_id_and_created_at", using: :btree
  add_index "discussions", ["user_id"], name: "index_discussions_on_user_id", using: :btree
  add_index "discussions", ["vehicle_make_id", "created_at"], name: "index_discussions_on_vehicle_make_id_and_created_at", using: :btree
  add_index "discussions", ["vehicle_make_id"], name: "index_discussions_on_vehicle_make_id", using: :btree
  add_index "discussions", ["vehicle_model_id", "created_at"], name: "index_discussions_on_vehicle_model_id_and_created_at", using: :btree
  add_index "discussions", ["vehicle_model_id"], name: "index_discussions_on_vehicle_model_id", using: :btree

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
  end

  add_index "favorite_autoparts", ["user_id", "autopart_id"], name: "index_favorite_autoparts_on_user_id_and_autopart_id", unique: true, using: :btree
  add_index "favorite_autoparts", ["user_id", "created_at"], name: "index_favorite_autoparts_on_user_id_and_created_at", using: :btree

  create_table "favorite_vehicles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "vehicle_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.boolean  "is_liked"
    t.boolean  "is_loved"
    t.boolean  "is_test_drive"
    t.boolean  "is_purchase"
    t.boolean  "is_disliked"
  end

  add_index "favorite_vehicles", ["user_id", "created_at"], name: "index_favorite_vehicles_on_user_id_and_created_at", using: :btree
  add_index "favorite_vehicles", ["user_id", "vehicle_id"], name: "index_favorite_vehicles_on_user_id_and_vehicle_id", unique: true, using: :btree

  create_table "inquiries", force: :cascade do |t|
    t.datetime "date"
    t.integer  "user_id"
    t.integer  "vehicle_id"
    t.integer  "conversation_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "inquiries", ["conversation_id"], name: "index_inquiries_on_conversation_id", using: :btree
  add_index "inquiries", ["user_id", "date"], name: "index_inquiries_on_user_id_and_date", using: :btree
  add_index "inquiries", ["user_id"], name: "index_inquiries_on_user_id", using: :btree
  add_index "inquiries", ["vehicle_id"], name: "index_inquiries_on_vehicle_id", using: :btree

  create_table "invitations", force: :cascade do |t|
    t.string   "email"
    t.string   "token"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.integer  "club_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "invitations", ["club_id", "created_at"], name: "index_invitations_on_club_id_and_created_at", using: :btree
  add_index "invitations", ["recipient_id", "created_at"], name: "index_invitations_on_recipient_id_and_created_at", using: :btree
  add_index "invitations", ["sender_id", "created_at"], name: "index_invitations_on_sender_id_and_created_at", using: :btree

  create_table "listing_scores", force: :cascade do |t|
    t.integer  "location_score"
    t.integer  "features_score"
    t.integer  "spec_score"
    t.integer  "vin_score"
    t.integer  "certified_dealer_score"
    t.integer  "direct_listing_score"
    t.integer  "test_drive_score"
    t.integer  "photos_score"
    t.integer  "reviews_score"
    t.integer  "recently_posted_score"
    t.integer  "many_listings_score"
    t.integer  "overall_score"
    t.integer  "vehicle_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "listing_scores", ["vehicle_id"], name: "index_listing_scores_on_vehicle_id", using: :btree

  create_table "memberships", force: :cascade do |t|
    t.boolean  "admin"
    t.integer  "user_id"
    t.integer  "club_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "memberships", ["user_id", "club_id"], name: "index_memberships_on_user_id_and_club_id", unique: true, using: :btree
  add_index "memberships", ["user_id", "created_at"], name: "index_memberships_on_user_id_and_created_at", using: :btree

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
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.boolean  "received"
    t.integer  "user_id"
    t.integer  "vehicle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "payments", ["user_id"], name: "index_payments_on_user_id", using: :btree
  add_index "payments", ["vehicle_id", "created_at"], name: "index_payments_on_vehicle_id_and_created_at", using: :btree
  add_index "payments", ["vehicle_id"], name: "index_payments_on_vehicle_id", using: :btree

  create_table "personalized_searches", force: :cascade do |t|
    t.integer  "price"
    t.integer  "mileage"
    t.integer  "year"
    t.boolean  "is_classic_vintage"
    t.boolean  "is_cruiser"
    t.boolean  "is_dual_sport"
    t.boolean  "is_mini_pocket"
    t.boolean  "is_moped"
    t.boolean  "is_sportbike"
    t.boolean  "is_standard"
    t.boolean  "is_touring"
    t.boolean  "is_trike"
    t.boolean  "cruise_control"
    t.boolean  "am_fm"
    t.boolean  "cb_radio"
    t.boolean  "navigation_system"
    t.boolean  "heated_seats"
    t.boolean  "heated_hand_grips"
    t.boolean  "alarm_system"
    t.boolean  "saddlebags"
    t.boolean  "trunk"
    t.boolean  "tow_hitch"
    t.boolean  "cycle_cover"
    t.integer  "user_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "personalized_searches", ["user_id"], name: "index_personalized_searches_on_user_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.datetime "last_found_at"
    t.integer  "vehicle_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "rotation",           default: 0, null: false
    t.integer  "scraped_id"
  end

  add_index "photos", ["vehicle_id"], name: "index_photos_on_vehicle_id", using: :btree

  create_table "post_comments", force: :cascade do |t|
    t.string   "content"
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "post_comments", ["post_id", "created_at"], name: "index_post_comments_on_post_id_and_created_at", using: :btree
  add_index "post_comments", ["post_id"], name: "index_post_comments_on_post_id", using: :btree
  add_index "post_comments", ["user_id"], name: "index_post_comments_on_user_id", using: :btree

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
  end

  add_index "posts", ["cached_votes_up"], name: "index_posts_on_cached_votes_up", using: :btree
  add_index "posts", ["club_id", "created_at"], name: "index_posts_on_club_id_and_created_at", using: :btree
  add_index "posts", ["club_id"], name: "index_posts_on_club_id", using: :btree
  add_index "posts", ["user_id", "created_at"], name: "index_posts_on_user_id_and_created_at", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree
  add_index "posts", ["vehicle_make_id", "created_at"], name: "index_posts_on_vehicle_make_id_and_created_at", using: :btree
  add_index "posts", ["vehicle_make_id"], name: "index_posts_on_vehicle_make_id", using: :btree
  add_index "posts", ["vehicle_model_id", "created_at"], name: "index_posts_on_vehicle_model_id_and_created_at", using: :btree
  add_index "posts", ["vehicle_model_id"], name: "index_posts_on_vehicle_model_id", using: :btree

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
  end

  add_index "purchases", ["buyer_id", "created_at"], name: "index_purchases_on_buyer_id_and_created_at", using: :btree
  add_index "purchases", ["seller_id", "created_at"], name: "index_purchases_on_seller_id_and_created_at", using: :btree
  add_index "purchases", ["vehicle_id"], name: "index_purchases_on_vehicle_id", using: :btree

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
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.boolean  "is_anonymous"
  end

  add_index "questions", ["user_id"], name: "index_questions_on_user_id", using: :btree
  add_index "questions", ["vehicle_id", "created_at"], name: "index_questions_on_vehicle_id_and_created_at", using: :btree
  add_index "questions", ["vehicle_id"], name: "index_questions_on_vehicle_id", using: :btree

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
  end

  add_index "reviews", ["dealership_id", "created_at"], name: "index_reviews_on_dealership_id_and_created_at", using: :btree
  add_index "reviews", ["dealership_id"], name: "index_reviews_on_dealership_id", using: :btree
  add_index "reviews", ["reviewed_id", "created_at"], name: "index_reviews_on_reviewed_id_and_created_at", using: :btree
  add_index "reviews", ["reviewer_id", "created_at"], name: "index_reviews_on_reviewer_id_and_created_at", using: :btree
  add_index "reviews", ["vehicle_id", "created_at"], name: "index_reviews_on_vehicle_id_and_created_at", using: :btree

  create_table "special_offers", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "vehicle_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "special_offers", ["vehicle_id"], name: "index_special_offers_on_vehicle_id", using: :btree

  create_table "upgrades", force: :cascade do |t|
    t.string   "title"
    t.integer  "duration"
    t.integer  "price"
    t.integer  "vehicle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "upgrades", ["vehicle_id"], name: "index_upgrades_on_vehicle_id", using: :btree

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
    t.string   "dealer_position"
    t.integer  "industry_experience"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

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
  end

  add_index "vehicle_models", ["vehicle_make_id"], name: "index_vehicle_models_on_vehicle_make_id", using: :btree

  create_table "vehicles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "listing_name"
    t.string   "vehicle_make_name"
    t.integer  "vehicle_make_id"
    t.string   "vehicle_model_name"
    t.integer  "vehicle_model_id"
    t.integer  "msrp"
    t.integer  "actual_price"
    t.integer  "year"
    t.string   "mileage"
    t.integer  "mileage_numeric"
    t.string   "body_style"
    t.string   "color"
    t.string   "engine_type"
    t.string   "fuel_type"
    t.string   "vin"
    t.integer  "engine_size"
    t.text     "description"
    t.text     "description_clean"
    t.boolean  "cruise_control"
    t.boolean  "am_fm"
    t.boolean  "cb_radio"
    t.boolean  "navigation_system"
    t.boolean  "heated_seats"
    t.boolean  "heated_hand_grips"
    t.boolean  "alarm_system"
    t.boolean  "saddlebags"
    t.boolean  "trunk"
    t.boolean  "tow_hitch"
    t.boolean  "cycle_cover"
    t.string   "street_address"
    t.string   "apartment"
    t.string   "city"
    t.string   "state"
    t.string   "ad_url"
    t.datetime "last_found_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "sold_at"
    t.datetime "bumped_at"
    t.datetime "posted_at"
    t.integer  "dealership_id"
    t.integer  "scraped_id"
  end

  add_index "vehicles", ["dealership_id", "created_at"], name: "index_vehicles_on_dealership_id_and_created_at", using: :btree
  add_index "vehicles", ["dealership_id"], name: "index_vehicles_on_dealership_id", using: :btree
  add_index "vehicles", ["user_id", "created_at"], name: "index_vehicles_on_user_id_and_created_at", using: :btree
  add_index "vehicles", ["user_id"], name: "index_vehicles_on_user_id", using: :btree
  add_index "vehicles", ["vehicle_make_id"], name: "index_vehicles_on_vehicle_make_id", using: :btree
  add_index "vehicles", ["vehicle_model_id"], name: "index_vehicles_on_vehicle_model_id", using: :btree

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

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "appointments", "conversations"
  add_foreign_key "appointments", "users", column: "buyer_id"
  add_foreign_key "appointments", "vehicles"
  add_foreign_key "autopart_photos", "autoparts"
  add_foreign_key "autoparts", "users"
  add_foreign_key "availabilities", "vehicles"
  add_foreign_key "blogs", "users"
  add_foreign_key "business_hours", "dealerships"
  add_foreign_key "club_product_photos", "club_products"
  add_foreign_key "club_products", "clubs"
  add_foreign_key "conversations", "users", column: "recipient_id"
  add_foreign_key "conversations", "users", column: "sender_id"
  add_foreign_key "dealer_invitations", "dealerships"
  add_foreign_key "dealer_invitations", "users", column: "sender_id"
  add_foreign_key "dealerships", "users"
  add_foreign_key "discussion_comments", "discussions"
  add_foreign_key "discussion_comments", "users"
  add_foreign_key "discussions", "clubs"
  add_foreign_key "discussions", "users"
  add_foreign_key "discussions", "vehicle_makes"
  add_foreign_key "discussions", "vehicle_models"
  add_foreign_key "favorite_autoparts", "autoparts"
  add_foreign_key "favorite_autoparts", "users"
  add_foreign_key "favorite_vehicles", "users"
  add_foreign_key "favorite_vehicles", "vehicles"
  add_foreign_key "inquiries", "conversations"
  add_foreign_key "inquiries", "users"
  add_foreign_key "inquiries", "vehicles"
  add_foreign_key "invitations", "clubs"
  add_foreign_key "invitations", "users", column: "recipient_id"
  add_foreign_key "invitations", "users", column: "sender_id"
  add_foreign_key "listing_scores", "vehicles"
  add_foreign_key "memberships", "clubs"
  add_foreign_key "memberships", "users"
  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users"
  add_foreign_key "payments", "users"
  add_foreign_key "payments", "vehicles"
  add_foreign_key "personalized_searches", "users"
  add_foreign_key "photos", "vehicles"
  add_foreign_key "post_comments", "posts"
  add_foreign_key "post_comments", "users"
  add_foreign_key "posts", "clubs"
  add_foreign_key "posts", "users"
  add_foreign_key "posts", "vehicle_makes"
  add_foreign_key "posts", "vehicle_models"
  add_foreign_key "purchases", "users", column: "buyer_id"
  add_foreign_key "purchases", "users", column: "seller_id"
  add_foreign_key "purchases", "vehicles"
  add_foreign_key "questions", "users"
  add_foreign_key "questions", "vehicles"
  add_foreign_key "reviews", "dealerships"
  add_foreign_key "reviews", "users", column: "reviewed_id"
  add_foreign_key "reviews", "users", column: "reviewer_id"
  add_foreign_key "reviews", "vehicles"
  add_foreign_key "special_offers", "vehicles"
  add_foreign_key "upgrades", "vehicles"
  add_foreign_key "vehicle_models", "vehicle_makes"
  add_foreign_key "vehicles", "dealerships"
  add_foreign_key "vehicles", "users"
  add_foreign_key "vehicles", "vehicle_makes"
  add_foreign_key "vehicles", "vehicle_models"
end
