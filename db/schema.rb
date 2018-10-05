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

ActiveRecord::Schema.define(version: 2018_09_30_190425) do

  create_table "employees", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "position"
    t.datetime "hired_at"
    t.datetime "last_evaluation_at"
    t.datetime "next_evaluation_at"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["last_name"], name: "index_employees_on_last_name"
    t.index ["user_id"], name: "index_employees_on_user_id"
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

  create_table "templates", force: :cascade do |t|
    t.string "name"
    t.integer "state", default: 0
    t.integer "evaluations_count", default: 0
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
