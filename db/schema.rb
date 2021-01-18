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

ActiveRecord::Schema.define(version: 2021_01_18_071251) do

  create_table "app_configurations", force: :cascade do |t|
    t.float "income_tax_threshold"
    t.float "first_tax_rate"
    t.float "second_tax_rate"
    t.float "second_tax_amount"
    t.integer "year"
    t.float "health_amount_reduction"
    t.float "health_amount"
  end

  create_table "contributions", force: :cascade do |t|
    t.string "contribution_type"
    t.date "date"
    t.float "amount"
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_contributions_on_user_id"
  end

  create_table "operations", force: :cascade do |t|
    t.string "operation_type", null: false
    t.float "amount"
    t.text "description"
    t.date "date"
    t.integer "user_id", null: false
    t.string "invoice_no"
    t.string "contractor_name"
    t.string "contractor_address"
    t.string "operation_subtype"
    t.float "other_cost_amount"
    t.datetime "created_at", default: "2020-01-20 08:16:33", null: false
    t.index ["user_id"], name: "index_operations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
