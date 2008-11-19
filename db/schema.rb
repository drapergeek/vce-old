# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20081119032051) do

  create_table "annoucements", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "message"
    t.datetime "starts_at"
    t.datetime "ends_at"
  end

  create_table "buses", :force => true do |t|
    t.string  "name"
    t.integer "capacity", :limit => 11
    t.text    "info"
    t.integer "unit_id",  :limit => 11
  end

  create_table "campers", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fname"
    t.string   "lname"
    t.string   "mname"
    t.string   "pref_name"
    t.date     "dob"
    t.integer  "gender",                   :limit => 11
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.integer  "zip",                      :limit => 11
    t.string   "roomate_choice"
    t.string   "parent_lname"
    t.string   "parent_fname"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "emergency_name"
    t.string   "emergency_phone"
    t.string   "school"
    t.string   "teacher"
    t.integer  "grade",                    :limit => 11
    t.integer  "shirt_size",               :limit => 11
    t.string   "number"
    t.integer  "position",                 :limit => 11
    t.text     "health_concerns"
    t.integer  "bus_id",                   :limit => 11
    t.boolean  "inactive"
    t.text     "inactive_info"
    t.string   "email"
    t.string   "race"
    t.date     "last_tetnus_shot"
    t.boolean  "code_of_conduct"
    t.integer  "media_release",            :limit => 11
    t.boolean  "equine_release"
    t.integer  "rec_zone",                 :limit => 11
    t.string   "payment_number"
    t.boolean  "reference"
    t.boolean  "physician_insurance_info"
    t.boolean  "emergency_info"
    t.boolean  "immunizations_current"
    t.boolean  "release_authorization"
    t.boolean  "parental_signatures"
    t.integer  "pool_spotting",            :limit => 11
    t.string   "room_number"
    t.integer  "counselor_years",          :limit => 11
    t.integer  "pack_id",                  :limit => 11
    t.integer  "unit_id",                  :limit => 11
  end

  create_table "course_selections", :force => true do |t|
    t.integer "camper_id",  :limit => 11
    t.integer "course_id",  :limit => 11
    t.integer "preference", :limit => 11
  end

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "unit_id",     :limit => 11
    t.datetime "created_at"
  end

  create_table "packs", :force => true do |t|
    t.string  "name"
    t.integer "unit_id", :limit => 11
  end

  create_table "receipts", :force => true do |t|
    t.datetime "date"
    t.string   "fname"
    t.string   "lname"
    t.string   "address"
    t.string   "state"
    t.integer  "zip",                 :limit => 11
    t.string   "city"
    t.float    "amount"
    t.integer  "payment_method",      :limit => 11
    t.string   "payment_extra"
    t.string   "camper1"
    t.string   "camper1_id"
    t.string   "camper2"
    t.string   "camper2_id"
    t.string   "camper3"
    t.string   "camper3_id"
    t.integer  "account_id",          :limit => 11
    t.integer  "user_id",             :limit => 11
    t.string   "phone"
    t.boolean  "refund"
    t.datetime "refund_date"
    t.integer  "refund_check_number", :limit => 11
    t.float    "refund_amount"
    t.text     "refund_info"
    t.datetime "created_at"
    t.integer  "unit_id",             :limit => 11
  end

  create_table "rights", :force => true do |t|
    t.string "name"
    t.string "controller"
    t.string "action"
  end

  create_table "rights_roles", :id => false, :force => true do |t|
    t.integer "right_id", :limit => 11
    t.integer "role_id",  :limit => 11
  end

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id", :limit => 11
    t.integer "user_id", :limit => 11
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
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "lname"
    t.string   "fname"
    t.string   "content_type",                                    :default => "image/png"
    t.binary   "picture",                   :limit => 2147483647
    t.string   "title"
    t.integer  "unit_id",                   :limit => 11
  end

end
