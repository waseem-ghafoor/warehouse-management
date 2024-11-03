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

ActiveRecord::Schema[7.2].define(version: 2024_11_03_104526) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "designs", force: :cascade do |t|
    t.string "design_id"
    t.bigint "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_designs_on_project_id"
  end

  create_table "parts", force: :cascade do |t|
    t.string "part_number"
    t.string "material"
    t.string "dimension"
    t.integer "quantity"
    t.text "note"
    t.bigint "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_parts_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sub_part_histories", force: :cascade do |t|
    t.bigint "sub_part_id", null: false
    t.integer "qc_stage"
    t.integer "qc_status"
    t.string "qc_note"
    t.bigint "qc_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "worker_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "time_taken"
    t.index ["qc_user_id"], name: "index_sub_part_histories_on_qc_user_id"
    t.index ["sub_part_id"], name: "index_sub_part_histories_on_sub_part_id"
    t.index ["worker_id"], name: "index_sub_part_histories_on_worker_id"
  end

  create_table "sub_parts", force: :cascade do |t|
    t.float "part_number"
    t.string "sub_part_no"
    t.string "job_id"
    t.string "sap_order_number"
    t.integer "status"
    t.float "height"
    t.float "width"
    t.float "length"
    t.integer "qty_no"
    t.float "per_qty"
    t.float "totat_qty"
    t.datetime "start_time"
    t.datetime "stop_time"
    t.integer "time_taken"
    t.integer "stage"
    t.integer "quality_control"
    t.text "note"
    t.bigint "part_id", null: false
    t.bigint "worker_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "design_id"
    t.bigint "project_id"
    t.index ["design_id"], name: "index_sub_parts_on_design_id"
    t.index ["part_id"], name: "index_sub_parts_on_part_id"
    t.index ["project_id"], name: "index_sub_parts_on_project_id"
    t.index ["worker_id"], name: "index_sub_parts_on_worker_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "role", default: 0, null: false
    t.string "email", null: false
    t.text "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "designs", "projects"
  add_foreign_key "parts", "projects"
  add_foreign_key "sub_part_histories", "sub_parts"
  add_foreign_key "sub_part_histories", "users", column: "qc_user_id"
  add_foreign_key "sub_part_histories", "users", column: "worker_id"
  add_foreign_key "sub_parts", "designs"
  add_foreign_key "sub_parts", "parts"
  add_foreign_key "sub_parts", "projects"
  add_foreign_key "sub_parts", "users", column: "worker_id"
end
