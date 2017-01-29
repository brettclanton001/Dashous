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

ActiveRecord::Schema.define(version: 20170129142622) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "offers", force: :cascade do |t|
    t.integer  "trade_request_id", null: false
    t.integer  "user_id",          null: false
    t.string   "status",           null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.text     "message"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "reviewed_user_id",  null: false
    t.integer  "reviewing_user_id", null: false
    t.string   "tone",              null: false
    t.integer  "offer_id",          null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["reviewed_user_id", "reviewing_user_id", "offer_id"], name: "index_reviews_on_participants_and_offer", unique: true, using: :btree
  end

  create_table "trade_requests", force: :cascade do |t|
    t.string   "name",                        null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "user_id",                     null: false
    t.string   "kind",                        null: false
    t.string   "profit",                      null: false
    t.string   "location",                    null: false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "slug",                        null: false
    t.boolean  "active",      default: false, null: false
    t.string   "currency",                    null: false
    t.text     "description"
    t.index ["slug"], name: "index_trade_requests_on_slug", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "username",                            null: false
    t.string   "encrypted_email",                     null: false
    t.string   "encrypted_email_iv",                  null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "currency",                            null: false
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

end
