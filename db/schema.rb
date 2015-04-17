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

ActiveRecord::Schema.define(version: 20150417152124) do

  create_table "connections", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "target_id"
    t.string   "connection_status"
    t.boolean  "reach_out",         default: false, null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "connections", ["follower_id"], name: "index_connections_on_follower_id"
  add_index "connections", ["target_id"], name: "index_connections_on_target_id"

  create_table "goals", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "institutions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "zip"
    t.string   "city"
    t.string   "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "post_links", force: :cascade do |t|
    t.integer  "parent_post_id"
    t.integer  "child_post_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "post_topics", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "topic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "post_topics", ["post_id"], name: "index_post_topics_on_post_id"
  add_index "post_topics", ["topic_id"], name: "index_post_topics_on_topic_id"

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "goal_id"
    t.integer  "parent_post_id"
  end

  add_index "posts", ["goal_id"], name: "index_posts_on_goal_id"
  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "resource_topics", force: :cascade do |t|
    t.integer  "resource_id"
    t.integer  "topic_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "resource_topics", ["resource_id"], name: "index_resource_topics_on_resource_id"
  add_index "resource_topics", ["topic_id"], name: "index_resource_topics_on_topic_id"

  create_table "resources", force: :cascade do |t|
    t.string   "description"
    t.string   "title"
    t.string   "resource_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "url"
  end

  create_table "topics", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_institutions", force: :cascade do |t|
    t.string   "institution_type"
    t.integer  "user_id"
    t.integer  "institution_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "user_institutions", ["institution_id"], name: "index_user_institutions_on_institution_id"
  add_index "user_institutions", ["user_id"], name: "index_user_institutions_on_user_id"

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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.string   "image"
    t.text     "bio"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "github"
    t.integer  "location_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["location_id"], name: "index_users_on_location_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
