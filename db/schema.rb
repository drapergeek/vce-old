# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120410222422) do

  create_table "annoucements", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "message"
    t.datetime "starts_at"
    t.datetime "ends_at"
  end

  create_table "buses", :force => true do |t|
    t.string  "name"
    t.integer "capacity"
    t.text    "info"
    t.integer "unit_id"
  end

  create_table "campers", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fname"
    t.string   "lname"
    t.string   "mname"
    t.string   "pref_name"
    t.date     "dob"
    t.string   "gender"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.string   "roomate_choice"
    t.string   "parent_lname"
    t.string   "parent_fname"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "emergency_name"
    t.string   "emergency_phone"
    t.string   "school"
    t.string   "teacher"
    t.integer  "grade"
    t.string   "shirt_size"
    t.string   "number"
    t.string   "position"
    t.text     "health_concerns"
    t.integer  "bus_id"
    t.boolean  "inactive"
    t.text     "inactive_info"
    t.string   "email"
    t.string   "race"
    t.date     "last_tetnus_shot"
    t.boolean  "code_of_conduct"
    t.string   "media_release",            :default => "Yes"
    t.boolean  "equine_release"
    t.integer  "rec_zone"
    t.string   "payment_number"
    t.boolean  "reference"
    t.boolean  "physician_insurance_info"
    t.boolean  "emergency_info"
    t.boolean  "immunizations_current"
    t.boolean  "release_authorization"
    t.boolean  "parental_signatures"
    t.integer  "pool_spotting"
    t.string   "room_number"
    t.integer  "counselor_years"
    t.integer  "pack_id"
    t.integer  "unit_id"
    t.boolean  "collage_purchased"
    t.boolean  "fully_paid"
    t.string   "mother_name"
    t.string   "mother_phone"
    t.string   "mother_email"
    t.string   "father_name"
    t.string   "father_phone"
    t.string   "father_email"
    t.string   "guardian_name"
    t.string   "guardian_phone"
    t.string   "guardian_email"
  end

  create_table "course_selections", :force => true do |t|
    t.integer "camper_id"
    t.integer "course_id"
    t.integer "preference"
  end

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "unit_id"
    t.datetime "created_at"
  end

  create_table "packs", :force => true do |t|
    t.string  "name"
    t.integer "unit_id"
  end

  create_table "payments", :force => true do |t|
    t.integer  "receipt_id"
    t.integer  "camper_id"
    t.float    "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "receipts", :force => true do |t|
    t.datetime "date"
    t.string   "fname"
    t.string   "lname"
    t.string   "address"
    t.string   "state"
    t.integer  "zip"
    t.string   "city"
    t.float    "amount"
    t.string   "payment_method"
    t.string   "payment_extra"
    t.string   "camper1"
    t.string   "camper1_id"
    t.string   "camper2"
    t.string   "camper2_id"
    t.string   "camper3"
    t.string   "camper3_id"
    t.integer  "account_id"
    t.integer  "user_id"
    t.string   "phone"
    t.boolean  "refund"
    t.datetime "refund_date"
    t.integer  "refund_check_number"
    t.float    "refund_amount"
    t.text     "refund_info"
    t.datetime "created_at"
    t.integer  "unit_id"
    t.string   "email"
    t.boolean  "camper1_collage"
    t.boolean  "camper2_collage"
    t.boolean  "camper3_collage"
    t.float    "camper1_payment"
    t.float    "camper2_payment"
    t.float    "camper3_payment"
  end

  create_table "rights_roles", :id => false, :force => true do |t|
    t.integer "right_id"
    t.integer "role_id"
  end

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "schools", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id"
    t.text     "data"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "states", :force => true do |t|
    t.string "name"
  end

  create_table "units", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "camp_price"
    t.float    "collage_price"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "lname"
    t.string   "fname"
    t.string   "content_type",                             :default => "image/png"
    t.binary   "picture"
    t.string   "title"
    t.integer  "unit_id"
    t.string   "provider"
    t.string   "uid"
    t.boolean  "authorized",                               :default => false,       :null => false
    t.string   "encrypted_password",        :limit => 128
    t.string   "confirmation_token",        :limit => 128
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
