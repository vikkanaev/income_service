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

ActiveRecord::Schema.define(version: 2021_03_21_134031) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "operations", force: :cascade do |t|
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "RUB", null: false
    t.string "description"
    t.bigint "user_id", null: false
    t.bigint "period_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["period_id"], name: "index_operations_on_period_id"
    t.index ["user_id"], name: "index_operations_on_user_id"
  end

  create_table "periods", force: :cascade do |t|
    t.date "date"
    t.bigint "user_id", null: false
    t.integer "amount_total_cents", default: 0, null: false
    t.string "amount_total_currency", default: "RUB", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["date"], name: "index_periods_on_date"
    t.index ["user_id"], name: "index_periods_on_user_id"
  end

  create_table "user_sessions", force: :cascade do |t|
    t.uuid "uuid", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_user_sessions_on_user_id"
    t.index ["uuid"], name: "index_user_sessions_on_uuid"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email"
  end

  add_foreign_key "operations", "periods"
  add_foreign_key "operations", "users"
  add_foreign_key "periods", "users"
  add_foreign_key "user_sessions", "users"
end
