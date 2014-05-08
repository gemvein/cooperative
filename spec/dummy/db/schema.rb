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

ActiveRecord::Schema.define(version: 20130929005901) do

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"

  create_table "activity_items", force: true do |t|
    t.integer  "performer_id"
    t.string   "performer_type"
    t.string   "event"
    t.integer  "target_id"
    t.string   "target_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "topic"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activity_items", ["owner_id", "owner_type", "created_at", "topic"], name: "activity_items_owner_id_type_created_at_topic"
  add_index "activity_items", ["owner_id", "owner_type", "created_at"], name: "index_activity_items_on_owner_id_and_owner_type_and_created_at"

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "connections", force: true do |t|
    t.integer  "subscriber_id"
    t.string   "subscriber_type"
    t.integer  "publisher_id"
    t.string   "publisher_type"
    t.string   "topic"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "connections", ["publisher_id", "publisher_type", "topic"], name: "index_connections_on_publisher_id_and_publisher_type_and_topic", unique: true

  create_table "follows", force: true do |t|
    t.integer  "followable_id",                   null: false
    t.string   "followable_type",                 null: false
    t.integer  "follower_id",                     null: false
    t.string   "follower_type",                   null: false
    t.boolean  "blocked",         default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["followable_id", "followable_type"], name: "fk_followables"
  add_index "follows", ["follower_id", "follower_type"], name: "fk_follows"

  create_table "groups", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "public",      default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.integer  "parent_id"
    t.string   "subject"
    t.text     "body"
    t.boolean  "deleted_by_sender"
    t.boolean  "deleted_by_recipient"
    t.datetime "read_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["parent_id"], name: "index_messages_on_parent_id"
  add_index "messages", ["recipient_id", "deleted_by_recipient"], name: "index_messages_on_recipient_id_and_deleted_by_recipient"
  add_index "messages", ["sender_id", "deleted_by_sender"], name: "index_messages_on_sender_id_and_deleted_by_sender"

  create_table "pages", force: true do |t|
    t.integer  "parent_id"
    t.string   "pageable_type"
    t.integer  "pageable_id"
    t.string   "slug"
    t.string   "title"
    t.text     "description"
    t.text     "keywords"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["pageable_type", "pageable_id"], name: "index_pages_on_pageable_type_and_pageable_id"
  add_index "pages", ["parent_id"], name: "index_pages_on_parent_id"
  add_index "pages", ["slug"], name: "index_pages_on_slug"

  create_table "permissions", force: true do |t|
    t.string   "permissor_type"
    t.integer  "permissor_id"
    t.string   "permissible_type"
    t.integer  "permissible_id"
    t.string   "relationship_type", default: "none"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "permissions", ["permissible_type", "permissible_id"], name: "index_permissions_on_permissible_type_and_permissible_id"
  add_index "permissions", ["permissor_type", "permissor_id"], name: "index_permissions_on_permissor_type_and_permissor_id"

  create_table "person_ratings", force: true do |t|
    t.integer  "person_id"
    t.string   "person_type"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.decimal  "weight",        precision: 5, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "person_ratings", ["rateable_type"], name: "index_person_ratings_on_rateable_type"

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "statuses", force: true do |t|
    t.integer  "user_id"
    t.string   "shareable_type"
    t.integer  "shareable_id"
    t.text     "body"
    t.string   "url"
    t.string   "title"
    t.text     "description"
    t.string   "media_url"
    t.string   "media_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "statuses", ["shareable_type", "shareable_id"], name: "index_statuses_on_shareable_type_and_shareable_id"
  add_index "statuses", ["user_id"], name: "index_statuses_on_user_id"

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", force: true do |t|
    t.string "name"
  end

  create_table "user", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.string   "nickname"
    t.text     "bio"
    t.string   "theme"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "user", ["authentication_token"], name: "index_users_on_authentication_token", unique: true
  add_index "user", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "user", ["email"], name: "index_users_on_email", unique: true
  add_index "user", ["nickname"], name: "index_users_on_nickname", unique: true
  add_index "user", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "user", ["unlock_token"], name: "index_users_on_unlock_token", unique: true

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

end
