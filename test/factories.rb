Factory.define :user do |u|
    u.id 1
    u.fname 'Peter'
    u.lname  'Parker'
    u.login 'spiderman'
    u.email 'spiderman@marvel.com'
    u.authorized true
end

Factory.define :camper do |c|
  c.fname  "Gregory"
  c.mname   "Jason"
  c.lname   "Draper"
  c.pref_name   "Jason"
  c.gender   0
  c.position   1
  c.number  "B774"
  c.zip 13213
  c.phone1 "540-555-5555"
end

Factory.define :receipt do |r|
  r.fname "Bruce"
  r.lname "Wayne"
  r.phone "544-444-4444"
  r.address "21313 Wayne Manor Drive"
  r.city "Gotham"
  r.state "VA"
  r.zip "44242"
  r.amount "215.00"
  r.payment_method 1
  r.payment_extra "123123"
  r.camper1 "Sarah Wayne"
  r.camper1_id "B234"
  r.email "batman@dc.com"
  r.unit_id 1
end

# == Schema Information
#
# Table name: receipts
#
#  id                  :integer         not null, primary key
#  date                :datetime
#  fname               :string(255)
#  lname               :string(255)
#  address             :string(255)
#  state               :string(255)
#  zip                 :integer
#  city                :string(255)
#  amount              :float
#  payment_method      :integer
#  payment_extra       :string(255)
#  camper1             :string(255)
#  camper1_id          :string(255)
#  camper2             :string(255)
#  camper2_id          :string(255)
#  camper3             :string(255)
#  camper3_id          :string(255)
#  account_id          :integer
#  user_id             :integer
#  phone               :string(255)
#  refund              :boolean
#  refund_date         :datetime
#  refund_check_number :integer
#  refund_amount       :float
#  refund_info         :text
#  created_at          :datetime
#  unit_id             :integer
#  email               :string(255)
#


