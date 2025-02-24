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

ActiveRecord::Schema[7.1].define(version: 2025_02_24_013023) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "custom_categories", force: :cascade do |t|
    t.bigint "vendor_id"
    t.bigint "user_id"
    t.string "category_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_aliases", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "vendor_id"
    t.string "item_name"
    t.string "alias"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.integer "vendor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "receipt_items", force: :cascade do |t|
    t.bigint "receipt_id"
    t.bigint "vendor_id"
    t.bigint "item_id"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "receipts", force: :cascade do |t|
    t.bigint "vendor_id"
    t.bigint "user_id"
    t.float "balance"
    t.float "tax"
    t.float "subtotal"
    t.boolean "requires_attention"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "item_json"
  end

  create_table "user_vendors", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "vendor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "phone_number"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vendors", force: :cascade do |t|
    t.string "name"
    t.integer "default_category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
