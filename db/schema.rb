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

ActiveRecord::Schema.define(version: 20160212025739) do

  create_table "comments", force: :cascade do |t|
    t.string   "body",                       null: false
    t.boolean  "deleted",    default: false
    t.integer  "user_id"
    t.integer  "tanka_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "comments", ["tanka_id"], name: "index_comments_on_tanka_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "dais", force: :cascade do |t|
    t.string   "title",                         null: false
    t.string   "comment",                       null: false
    t.datetime "due"
    t.integer  "user_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "target_gender", default: 0
    t.string   "target_grade",  default: "0"
    t.boolean  "all_select",    default: true
    t.integer  "fase",          default: 1
    t.datetime "v_due"
    t.boolean  "vote_closed",   default: false
  end

  add_index "dais", ["user_id"], name: "index_dais_on_user_id"

  create_table "tankas", force: :cascade do |t|
    t.string   "body"
    t.boolean  "exposed",    default: true
    t.integer  "user_id"
    t.integer  "dai_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.boolean  "selected",   default: true
    t.integer  "kin_cnt",    default: 0
    t.integer  "ran_cnt",    default: 0
    t.integer  "sho_cnt",    default: 0
    t.integer  "ransho_cnt", default: 0
  end

  add_index "tankas", ["dai_id"], name: "index_tankas_on_dai_id"
  add_index "tankas", ["user_id"], name: "index_tankas_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "name"
    t.integer  "grade"
    t.integer  "gender"
    t.boolean  "holder",                 default: false
    t.boolean  "admin",                  default: false
    t.boolean  "contributor",            default: true
    t.string   "nickname"
    t.date     "nickname_update"
    t.integer  "soultanka_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true

  create_table "voterships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "tanka_id"
    t.integer  "dai_id"
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "voterships", ["dai_id"], name: "index_voterships_on_dai_id"
  add_index "voterships", ["tanka_id"], name: "index_voterships_on_tanka_id"
  add_index "voterships", ["user_id", "tanka_id", "dai_id", "type"], name: "index_voterships_on_user_id_and_tanka_id_and_dai_id_and_type", unique: true
  add_index "voterships", ["user_id"], name: "index_voterships_on_user_id"

end
