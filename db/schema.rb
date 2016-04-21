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

ActiveRecord::Schema.define(version: 20160421155303) do

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.string   "comment"
    t.boolean  "approved",   default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "ancestry"
  end

  add_index "comments", ["ancestry"], name: "index_comments_on_ancestry"

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.string   "event_date"
    t.string   "event_time"
    t.string   "description"
    t.string   "image"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "user_id"
    t.string   "hashtag"
    t.string   "event_pic_file_name"
    t.string   "event_pic_content_type"
    t.integer  "event_pic_file_size"
    t.datetime "event_pic_updated_at"
    t.string   "location"
    t.boolean  "tweets_approved",        default: true
    t.boolean  "comments_approved",      default: true
  end

  add_index "events", ["user_id"], name: "index_events_on_user_id"

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "occupation"
    t.text     "about_me"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "profile_pic_file_name"
    t.string   "profile_pic_content_type"
    t.integer  "profile_pic_file_size"
    t.datetime "profile_pic_updated_at"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "subscriber_id"
    t.integer  "subscribed_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "subscriptions", ["subscribed_id"], name: "index_subscriptions_on_subscribed_id"
  add_index "subscriptions", ["subscriber_id", "subscribed_id"], name: "index_subscriptions_on_subscriber_id_and_subscribed_id", unique: true
  add_index "subscriptions", ["subscriber_id"], name: "index_subscriptions_on_subscriber_id"

  create_table "tweets", force: :cascade do |t|
    t.string   "name"
    t.string   "username"
    t.string   "text"
    t.string   "id_str"
    t.boolean  "approved",         default: true
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "event_id"
    t.datetime "tweet_created_at"
    t.string   "hashtag"
    t.boolean  "deleted",          default: false
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
    t.string   "provider"
    t.string   "uid"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "username",               default: ""
    t.string   "profile_image",          default: ""
  end

  add_index "users", ["email", "provider", "uid"], name: "index_users_on_identity", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
