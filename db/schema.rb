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

ActiveRecord::Schema.define(version: 20160306021415) do

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
    t.boolean  "selecting",     default: false
    t.string   "comment2",      default: ""
    t.integer  "genre",         default: 0,     null: false
  end

  add_index "dais", ["user_id"], name: "index_dais_on_user_id"

  create_table "issens", force: :cascade do |t|
    t.string   "body",       null: false
    t.integer  "user_id"
    t.integer  "tanka_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "issens", ["tanka_id"], name: "index_issens_on_tanka_id"
  add_index "issens", ["user_id", "tanka_id"], name: "index_issens_on_user_id_and_tanka_id", unique: true
  add_index "issens", ["user_id"], name: "index_issens_on_user_id"

  create_table "kogyos", force: :cascade do |t|
    t.integer  "pick_type",     default: 1
    t.string   "notice"
    t.integer  "place",         default: 1
    t.integer  "season",        default: 0
    t.string   "hokku_name"
    t.datetime "next_due"
    t.float    "voting_hour"
    t.float    "thinking_hour", default: 48.0
    t.integer  "user_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "kogyos", ["user_id"], name: "index_kogyos_on_user_id"

  create_table "noteships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "notice_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "noteships", ["notice_id"], name: "index_noteships_on_notice_id"
  add_index "noteships", ["user_id", "notice_id"], name: "index_noteships_on_user_id_and_notice_id", unique: true
  add_index "noteships", ["user_id"], name: "index_noteships_on_user_id"

  create_table "notices", force: :cascade do |t|
    t.string   "body",                    null: false
    t.string   "link",       default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "renga_voterships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "renga_id"
    t.integer  "kogyo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "renga_voterships", ["kogyo_id"], name: "index_renga_voterships_on_kogyo_id"
  add_index "renga_voterships", ["renga_id"], name: "index_renga_voterships_on_renga_id"
  add_index "renga_voterships", ["user_id"], name: "index_renga_voterships_on_user_id"

  create_table "rengas", force: :cascade do |t|
    t.string   "body"
    t.boolean  "selected",   default: true
    t.boolean  "picked",     default: false
    t.integer  "place",                      null: false
    t.integer  "user_id"
    t.integer  "kogyo_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "rengas", ["kogyo_id"], name: "index_rengas_on_kogyo_id"
  add_index "rengas", ["user_id"], name: "index_rengas_on_user_id"

  create_table "tankas", force: :cascade do |t|
    t.string   "body"
    t.boolean  "exposed",      default: true
    t.integer  "user_id"
    t.integer  "dai_id"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.boolean  "selected",     default: true
    t.integer  "kin_cnt",      default: 0
    t.integer  "ran_cnt",      default: 0
    t.integer  "sho_cnt",      default: 0
    t.integer  "ransho_cnt",   default: 0
    t.datetime "submitted_at", default: '2016-02-26 01:45:36'
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
