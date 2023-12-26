# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_12_25_140030) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "disbursements", force: :cascade do |t|
    t.integer "merchant_id", null: false
    t.decimal "amount", precision: 10, scale: 2, default: "0.0", null: false
    t.date "creation_date"
    t.decimal "fee", precision: 10, scale: 2, default: "0.0", null: false
    t.integer "year", null: false
    t.integer "month", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["merchant_id"], name: "unique_merchant", unique: true
  end

  create_table "merchants", force: :cascade do |t|
    t.string "reference", null: false
    t.string "email"
    t.date "live_on", null: false
    t.integer "disbursement_frequency", null: false
    t.decimal "minimum_monthly_fee", precision: 10, scale: 2, default: "0.0", null: false
    t.string "id_key"
    t.decimal "monthly_fee_payment", precision: 10, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reference"], name: "unique_reference", unique: true
  end

  create_table "orders", force: :cascade do |t|
    t.integer "merchant_id", null: false
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.date "creation_date", null: false
    t.integer "disbursement_id"
    t.string "id_key"
    t.decimal "fee", precision: 10, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["disbursement_id"], name: "disbursement_id_index"
    t.index ["merchant_id"], name: "index_orders_on_merchant_id"
  end

  create_table "scheduled_tasks", force: :cascade do |t|
    t.integer "merchant_id", null: false
    t.date "scheduled_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["merchant_id"], name: "unique_merchant_task", unique: true
  end

end
