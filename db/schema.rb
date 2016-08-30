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

ActiveRecord::Schema.define(version: 20160828094808) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "name"
    t.string   "site_url"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.boolean  "slack_publishing", default: false, null: false
    t.string   "stripe_id"
    t.integer  "pricing_plan_id",  default: 1,     null: false
    t.index ["pricing_plan_id"], name: "index_accounts_on_pricing_plan_id", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
  end

  create_table "credit_cards", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "account_id"
    t.string   "last_4"
    t.string   "token"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "stripe_id"
    t.index ["account_id"], name: "index_credit_cards_on_account_id", using: :btree
  end

  create_table "default_variables", force: :cascade do |t|
    t.string  "name"
    t.string  "value"
    t.string  "framework"
    t.string  "version"
    t.integer "category_id"
    t.integer "position",    null: false
  end

  create_table "inquiries", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name",       null: false
    t.string   "email",      null: false
    t.text     "message",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_inquiries_on_user_id", using: :btree
  end

  create_table "pricing_plans", force: :cascade do |t|
    t.string   "name",                               null: false
    t.integer  "price",                              null: false
    t.integer  "number_of_users"
    t.integer  "number_of_requests"
    t.boolean  "slack_integration",  default: false, null: false
    t.integer  "position"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "slack_authentications", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "token"
    t.string   "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_slack_authentications_on_account_id", using: :btree
  end

  create_table "stylesheets", force: :cascade do |t|
    t.string   "name"
    t.string   "framework"
    t.string   "version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "account_id"
    t.index ["account_id"], name: "index_stylesheets_on_account_id", using: :btree
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
    t.integer  "account_id"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.string   "invited_by_type"
    t.integer  "invited_by_id"
    t.integer  "invitations_count",      default: 0
    t.integer  "role",                   default: 0,  null: false
    t.index ["account_id"], name: "index_users_on_account_id", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
    t.index ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "variables", force: :cascade do |t|
    t.integer  "stylesheet_id"
    t.string   "name"
    t.string   "value"
    t.string   "preview_value"
    t.integer  "position"
    t.boolean  "default"
    t.integer  "category_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["stylesheet_id"], name: "index_variables_on_stylesheet_id", using: :btree
  end

  add_foreign_key "accounts", "pricing_plans"
  add_foreign_key "inquiries", "users"
  add_foreign_key "stylesheets", "accounts"
  add_foreign_key "users", "accounts"
end
