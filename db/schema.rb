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

ActiveRecord::Schema.define(version: 20160930202114) do

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
    t.string   "purpose_quantity"
    t.text     "image_url",        limit: 65535
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
    t.boolean  "status",                                        default: true
    t.index ["nick_name", "email", "token"], name: "index_users_on_nick_name_and_email_and_token", using: :btree
  end

end
