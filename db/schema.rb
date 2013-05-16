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

ActiveRecord::Schema.define(:version => 20130416224546) do

  create_table "matches", :force => true do |t|
    t.integer  "defender_id"
    t.integer  "challenger_id"
    t.integer  "winner_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "players", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.boolean  "active",     :default => true
  end

  create_table "ratings", :force => true do |t|
    t.integer  "team_id"
    t.integer  "value",      :default => 0
    t.float    "mean",       :default => 2500.0
    t.float    "deviation",  :default => 833.0
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "rosters", :force => true do |t|
    t.integer  "player_id"
    t.integer  "team_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "teams", :force => true do |t|
    t.integer  "ladder",     :default => 1
    t.string   "name"
    t.integer  "rank"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

end
