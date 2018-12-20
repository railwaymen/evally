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

ActiveRecord::Schema.define(version: 2018_12_08_230505) do

  create_table "activities", force: :cascade do |t|
    t.string "action"
    t.string "activable_name"
    t.string "activable_type"
    t.integer "activable_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activable_type", "activable_id"], name: "index_activities_on_activable_type_and_activable_id"
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "position"
    t.datetime "hired_at"
    t.datetime "next_evaluation_at"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "public_token"
    t.integer "state", default: 0
    t.datetime "released_at"
    t.index ["last_name"], name: "index_employees_on_last_name"
    t.index ["public_token"], name: "index_employees_on_public_token", unique: true
    t.index ["user_id"], name: "index_employees_on_user_id"
  end

  create_table "evaluations", force: :cascade do |t|
    t.integer "employee_id"
    t.integer "state", default: 0
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "template_name"
    t.index ["employee_id"], name: "index_evaluations_on_employee_id"
  end

  create_table "sections", force: :cascade do |t|
    t.string "name"
    t.integer "group"
    t.integer "width"
    t.integer "position"
    t.json "skills", default: []
    t.string "sectionable_type"
    t.integer "sectionable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_sections_on_name"
    t.index ["sectionable_type", "sectionable_id"], name: "index_sections_on_sectionable_type_and_sectionable_id"
  end

  create_table "settings", force: :cascade do |t|
    t.integer "user_id"
    t.integer "default_draft_items", default: 5
    t.integer "default_upcoming_items", default: 5
    t.integer "default_next_evaluation_time", default: 6
    t.boolean "public_view_enabled", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "lang", default: "en"
    t.index ["user_id"], name: "index_settings_on_user_id"
  end

  create_table "templates", force: :cascade do |t|
    t.string "name"
    t.integer "state", default: 0
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_templates_on_name"
    t.index ["user_id"], name: "index_templates_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "auth_tokens"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
