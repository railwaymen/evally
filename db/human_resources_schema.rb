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

ActiveRecord::Schema.define(version: 2020_03_05_093549) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "recruit_documents", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "gender"
    t.string "email", null: false
    t.string "encrypted_email", null: false
    t.string "phone"
    t.string "position", null: false
    t.string "group", null: false
    t.datetime "received_at", null: false
    t.string "source", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_recruit_documents_on_email", unique: true
    t.index ["encrypted_email"], name: "index_recruit_documents_on_encrypted_email"
    t.index ["group"], name: "index_recruit_documents_on_group"
  end

end
