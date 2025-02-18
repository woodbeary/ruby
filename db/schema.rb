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

ActiveRecord::Schema[7.2].define(version: 2024_10_28_220400) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "incidents", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "status", default: "open"
    t.bigint "user_id"
    t.string "submitted_priority"
    t.string "assigned_priority"
    t.datetime "priority_changed_at"
    t.bigint "priority_changed_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assigned_priority"], name: "index_incidents_on_assigned_priority"
    t.index ["priority_changed_by_id"], name: "index_incidents_on_priority_changed_by_id"
    t.index ["submitted_priority"], name: "index_incidents_on_submitted_priority"
    t.index ["user_id"], name: "index_incidents_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "incidents", "users"
  add_foreign_key "incidents", "users", column: "priority_changed_by_id"
end
