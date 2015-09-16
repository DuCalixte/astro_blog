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

ActiveRecord::Schema.define(version: 20150815033520) do

  create_table "astro_blogs", id: false, force: :cascade do |t|
    t.string   "uuid",        limit: 50,    null: false
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.string   "url",         limit: 255
    t.text     "explanation", limit: 65535
    t.string   "picture_url", limit: 255
    t.datetime "date"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "astro_blogs", ["title", "url"], name: "astro_blogs_title_with_link", unique: true, using: :btree

end
