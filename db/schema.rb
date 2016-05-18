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

ActiveRecord::Schema.define(version: 20160518052833) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "directed_ats", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "toot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "directed_ats", ["toot_id"], name: "index_directed_ats_on_toot_id", using: :btree
  add_index "directed_ats", ["user_id"], name: "index_directed_ats_on_user_id", using: :btree

  create_table "favorites", force: :cascade do |t|
    t.integer  "toot_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "favorites", ["toot_id"], name: "index_favorites_on_toot_id", using: :btree
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

  create_table "follows", force: :cascade do |t|
    t.integer  "followed_id"
    t.integer  "follower_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "follows", ["followed_id", "follower_id"], name: "index_follows_on_followed_id_and_follower_id", unique: true, using: :btree
  add_index "follows", ["followed_id"], name: "index_follows_on_followed_id", using: :btree
  add_index "follows", ["follower_id"], name: "index_follows_on_follower_id", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "mentions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "toot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "mentions", ["toot_id"], name: "index_mentions_on_toot_id", using: :btree
  add_index "mentions", ["user_id", "toot_id"], name: "index_mentions_on_user_id_and_toot_id", unique: true, using: :btree
  add_index "mentions", ["user_id"], name: "index_mentions_on_user_id", using: :btree

  create_table "retoots", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "toot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggeds", force: :cascade do |t|
    t.integer  "tag_id",     null: false
    t.integer  "toot_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "taggeds", ["tag_id"], name: "index_taggeds_on_tag_id", using: :btree
  add_index "taggeds", ["toot_id"], name: "index_taggeds_on_toot_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "tag",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tags", ["tag"], name: "index_tags_on_tag", using: :btree

  create_table "toot_replies", force: :cascade do |t|
    t.integer  "toot_id"
    t.integer  "reply_toot_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "toot_replies", ["reply_toot_id"], name: "index_toot_replies_on_reply_toot_id", using: :btree
  add_index "toot_replies", ["toot_id"], name: "index_toot_replies_on_toot_id", using: :btree

  create_table "toots", force: :cascade do |t|
    t.text     "message"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "toots", ["user_id"], name: "index_toots_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "name"
    t.text     "bio"
    t.string   "location"
    t.string   "website"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "reply"
    t.integer  "at"
    t.string   "slug"
    t.string   "at_username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", using: :btree

  add_foreign_key "directed_ats", "toots"
  add_foreign_key "directed_ats", "users"
  add_foreign_key "favorites", "toots"
  add_foreign_key "favorites", "users"
  add_foreign_key "mentions", "toots"
  add_foreign_key "mentions", "users"
  add_foreign_key "taggeds", "tags"
  add_foreign_key "taggeds", "toots"
  add_foreign_key "toot_replies", "toots"
  add_foreign_key "toots", "users"
end
