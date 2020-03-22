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

ActiveRecord::Schema.define(version: 2020_03_21_220957) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "action"
    t.string "activable_name"
    t.string "activable_type"
    t.bigint "activable_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activable_type", "activable_id"], name: "index_activities_on_activable_type_and_activable_id"
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "recruit_id", null: false
    t.bigint "user_id", null: false
    t.text "body", null: false
    t.string "created_by", default: "human", null: false
    t.datetime "discarded_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recruit_id"], name: "index_comments_on_recruit_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "position", null: false
    t.date "hired_on", null: false
    t.date "next_evaluation_on"
    t.bigint "evaluator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "public_token", null: false
    t.string "state", default: "hired", null: false
    t.datetime "released_at"
    t.string "group", default: "Unassigned", null: false
    t.date "position_set_on"
    t.date "archived_on"
    t.index ["evaluator_id"], name: "index_employees_on_evaluator_id"
    t.index ["group"], name: "index_employees_on_group"
    t.index ["last_name"], name: "index_employees_on_last_name"
    t.index ["public_token"], name: "index_employees_on_public_token", unique: true
    t.index ["state"], name: "index_employees_on_state"
  end

  create_table "evaluations", force: :cascade do |t|
    t.bigint "evaluable_id"
    t.string "state", default: "draft", null: false
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "template_name"
    t.string "evaluable_type", null: false
    t.string "position", null: false
    t.index ["evaluable_type", "evaluable_id"], name: "index_evaluations_on_evaluable_type_and_evaluable_id"
    t.index ["state"], name: "index_evaluations_on_state"
  end

  create_table "position_changes", force: :cascade do |t|
    t.string "previous_position", null: false
    t.string "current_position", null: false
    t.date "changed_on", null: false
    t.bigint "employee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_position_changes_on_employee_id"
  end

  create_table "recruits", force: :cascade do |t|
    t.string "public_recruit_id", null: false
    t.bigint "evaluator_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["evaluator_id"], name: "index_recruits_on_evaluator_id"
    t.index ["public_recruit_id"], name: "index_recruits_on_public_recruit_id", unique: true
  end

  create_table "sections", force: :cascade do |t|
    t.string "name", null: false
    t.string "group", null: false
    t.string "width", null: false
    t.integer "position", default: 0
    t.jsonb "skills", default: []
    t.string "sectionable_type", null: false
    t.bigint "sectionable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "sensitive", default: false, null: false
    t.index ["name"], name: "index_sections_on_name"
    t.index ["sectionable_type", "sectionable_id"], name: "index_sections_on_sectionable_type_and_sectionable_id"
  end

  create_table "settings", force: :cascade do |t|
    t.bigint "user_id"
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
    t.string "name", null: false
    t.bigint "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "destination", null: false
    t.index ["creator_id"], name: "index_templates_on_creator_id"
    t.index ["name"], name: "index_templates_on_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", default: "evaluator", null: false
    t.string "status", default: "active", null: false
    t.inet "last_sign_in_ip"
    t.datetime "last_sign_in_at"
    t.string "invitation_token"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.datetime "invitation_created_at"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string "encrypted_password", null: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.inet "current_sign_in_ip"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role"], name: "index_users_on_role"
    t.index ["status"], name: "index_users_on_status"
  end

  add_foreign_key "activities", "users"
  add_foreign_key "comments", "recruits"
  add_foreign_key "comments", "users"
  add_foreign_key "employees", "users", column: "evaluator_id"
  add_foreign_key "position_changes", "employees"
  add_foreign_key "recruits", "users", column: "evaluator_id"
  add_foreign_key "settings", "users"
  add_foreign_key "templates", "users", column: "creator_id"
end
