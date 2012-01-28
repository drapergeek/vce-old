FactoryGirl.define do 

  factory :user do |u|
    u.fname 'Peter'
    u.lname  'Parker'
    u.email 'spiderman@marvel.com'
    u.authorized true
  end

  factory :camper do |c|
    c.fname  "Gregory"
    c.mname   "Jason"
    c.lname   "Draper"
    c.pref_name   "Jason"
    c.gender   0
    c.position   1
    c.number  "B784"
    c.zip "12345"
    c.phone1 "540-555-5555"
  end

  factory :receipt do |r|
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
    r.camper1_payment 20.00
    r.camper1_collage true
    r.email "batman@dc.com"
    r.association :unit
  end

  factory :all_camper_receipt, :parent=>:receipt do |r|
    r.camper2 "Bruce Way"
    r.camper2_id "B322"
    r.camper2_payment 210.00
    r.camper2_collage true
    r.camper3 "Sarah Jane"
    r.camper3_id "G331"
    r.camper3_payment 210.00
    r.camper3_collage true
  end


  factory :bus do |b|
    b.name "12"
    b.capacity 30
  end

  factory :school do |s|
    s.name "RAE"
  end

  factory :unit do |u|
    u.name "Henry County"
    u.camp_price 210.00
    u.collage_price 10.00
  end

end
