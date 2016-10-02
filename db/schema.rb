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

ActiveRecord::Schema.define(version: 20161002060513) do

  create_table "activities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin" do |t|
    t.integer  "user_id"
    t.integer  "calories"
    t.integer  "steps"
    t.date     "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "goals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin" do |t|
    t.integer  "partner_id"
    t.string   "name"
    t.text     "description",          limit: 65535
    t.integer  "purpose"
    t.integer  "purpose_quantity"
    t.string   "category"
    t.datetime "start_at"
    t.datetime "end_at"
    t.string   "time_window_category"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.boolean  "status",                             default: true
    t.index ["purpose", "category", "time_window_category"], name: "index_goals_on_purpose_and_category_and_time_window_category", using: :btree
  end

  create_table "partners", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin" do |t|
    t.string   "name"
    t.text     "description",      limit: 65535
    t.string   "slug_type"
    t.integer  "purpose_category"
    t.string   "speciality"
    t.string   "contact_type"
    t.string   "contact_info"
    t.text     "image_url",        limit: 65535
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.boolean  "status",                         default: true
  end

  create_table "subscriptions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin" do |t|
    t.integer  "user_id"
    t.integer  "partner_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.boolean  "status",     default: true
    t.index ["user_id", "partner_id"], name: "index_subscriptions_on_user_id_and_partner_id", using: :btree
  end

  create_table "user_achieved_goals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin" do |t|
    t.integer  "user_id"
    t.integer  "goal_id"
    t.string   "reward"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin" do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "nick_name"
    t.string   "email"
    t.string   "password"
    t.string   "token"
    t.string   "device_so"
    t.integer  "gender"
    t.integer  "age"
    t.decimal  "height",                         precision: 10
    t.decimal  "weight",                         precision: 10
    t.integer  "purpose"
    t.integer  "purpose_quantity"
    t.text     "image_url",        limit: 65535
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
    t.boolean  "status",                                        default: true
    t.index ["nick_name", "email", "token"], name: "index_users_on_nick_name_and_email_and_token", using: :btree
  end

end
