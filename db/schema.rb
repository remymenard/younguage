# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_02_181114) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string "url"
    t.string "title"
    t.text "content"
    t.string "author"
    t.bigint "topic_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "date"
    t.index ["topic_id"], name: "index_articles_on_topic_id"
  end

  create_table "daily_reports", force: :cascade do |t|
    t.string "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "day"
    t.string "letter"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_daily_reports_on_user_id"
  end

  create_table "flashcards", force: :cascade do |t|
    t.bigint "word_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "response"
    t.boolean "mastered", default: false
    t.integer "score_result"
    t.bigint "list_id"
    t.datetime "last_view"
    t.index ["list_id"], name: "index_flashcards_on_list_id"
    t.index ["word_id"], name: "index_flashcards_on_word_id"
  end

  create_table "lists", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_lists_on_user_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "topics", default: [], array: true
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "words", force: :cascade do |t|
    t.string "word"
    t.string "translation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "score"
    t.bigint "user_id"
    t.datetime "last_review"
    t.index ["user_id"], name: "index_words_on_user_id"
  end

  add_foreign_key "articles", "topics"
  add_foreign_key "daily_reports", "users"
  add_foreign_key "flashcards", "lists"
  add_foreign_key "flashcards", "words"
  add_foreign_key "lists", "users"
  add_foreign_key "words", "users"
end
