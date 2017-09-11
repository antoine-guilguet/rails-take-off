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

ActiveRecord::Schema.define(version: 20170908165021) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ar_internal_metadata", primary_key: "key", force: :cascade do |t|
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expenses", force: :cascade do |t|
    t.float    "amount"
    t.integer  "user_id"
    t.integer  "trip_id"
    t.integer  "topic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "expenses", ["topic_id"], name: "index_expenses_on_topic_id", using: :btree
  add_index "expenses", ["trip_id"], name: "index_expenses_on_trip_id", using: :btree
  add_index "expenses", ["user_id"], name: "index_expenses_on_user_id", using: :btree

  create_table "invites", force: :cascade do |t|
    t.integer  "trip_id"
    t.integer  "host_id"
    t.string   "token"
    t.string   "email"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "recipient_id"
    t.boolean  "confirmed",    default: false
  end

  add_index "invites", ["trip_id"], name: "index_invites_on_trip_id", using: :btree

  create_table "suggestions", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.float    "price"
    t.integer  "topic_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "suggestions", ["topic_id"], name: "index_suggestions_on_topic_id", using: :btree
  add_index "suggestions", ["user_id"], name: "index_suggestions_on_user_id", using: :btree

  create_table "survey_dates", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "survey_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "survey_dates", ["survey_id"], name: "index_survey_dates_on_survey_id", using: :btree

  create_table "surveys", force: :cascade do |t|
    t.datetime "deadline"
    t.integer  "trip_id"
    t.boolean  "completed",  default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "surveys", ["trip_id"], name: "index_surveys_on_trip_id", using: :btree

  create_table "topics", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.string   "status"
    t.float    "expense"
    t.datetime "deadline"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "trip_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "topics", ["trip_id"], name: "index_topics_on_trip_id", using: :btree
  add_index "topics", ["user_id"], name: "index_topics_on_user_id", using: :btree

  create_table "trip_participants", force: :cascade do |t|
    t.integer  "trip_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "trip_participants", ["trip_id"], name: "index_trip_participants_on_trip_id", using: :btree
  add_index "trip_participants", ["user_id"], name: "index_trip_participants_on_user_id", using: :btree

  create_table "trips", force: :cascade do |t|
    t.string   "name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.datetime "deadline"
    t.string   "destination"
    t.boolean  "created",     default: false
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "user_id"
  end

  add_index "trips", ["user_id"], name: "index_trips_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "provider"
    t.string   "uid"
    t.string   "facebook_picture_url"
    t.string   "token"
    t.datetime "token_expiry"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

  add_foreign_key "expenses", "topics"
  add_foreign_key "expenses", "trips"
  add_foreign_key "expenses", "users"
  add_foreign_key "invites", "trips"
  add_foreign_key "suggestions", "topics"
  add_foreign_key "suggestions", "users"
  add_foreign_key "survey_dates", "surveys"
  add_foreign_key "surveys", "trips"
  add_foreign_key "topics", "trips"
  add_foreign_key "topics", "users"
  add_foreign_key "trip_participants", "trips"
  add_foreign_key "trip_participants", "users"
  add_foreign_key "trips", "users"
end
