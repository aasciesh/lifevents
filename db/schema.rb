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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130228184907) do

  create_table "comments", :force => true do |t|
    t.text     "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "urgency"
    t.datetime "post_date"
    t.datetime "from_time"
    t.datetime "to_time"
    t.integer  "priority_point"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
    t.string   "category"
  end

  create_table "taglists", :force => true do |t|
    t.integer  "user_id"
    t.integer  "tag_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "ip"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "remember_cookie"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["remember_cookie"], :name => "index_users_on_remember_cookie"

end
