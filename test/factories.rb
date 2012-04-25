FactoryGirl.define do

  sequence(:camper_number) { |n| "CB12#{n}" }

  factory :user do
    fname 'Peter'
    lname  'Parker'
    email 'spiderman@marvel.com'
    title 'SPIDERMAN'
    password "myfakepass"
    password_confirmation {|u| u.password}
    authorized true
    association :unit
  end

  factory :role do
    name "admin"
  end

  factory :camper do
    fname  "Gregory"
    mname   "Jason"
    lname   "Draper"
    pref_name   "Jason"
    gender   0
    position   1
    number  "B784"
    zip "12345"
    phone1 "540-555-5555"
  end

  factory :receipt do
    fname "Bruce"
    lname "Wayne"
    phone "544-444-4444"
    address "21313 Wayne Manor Drive"
    city "Gotham"
    state "VA"
    zip "44242"
    amount "215.00"
    payment_method 1
    payment_extra "123123"
    camper1 "Sarah Wayne"
    camper1_id "B234"
    camper1_payment 20.00
    camper1_collage true
    email "batman@dc.com"
    association :unit
  end

  factory :all_camper_receipt, :parent=>:receipt do
    camper2 "Bruce Way"
    camper2_id "B322"
    camper2_payment 210.00
    camper2_collage true
    camper3 "Sarah Jane"
    camper3_id "G331"
    camper3_payment 210.00
    camper3_collage true
  end


  factory :bus do
    name "12"
    capacity 30
  end

  factory :school do
    name "RAE"
  end

  factory :unit do
    name "Henry County"
    camp_price 210.00
    collage_price 10.00
  end

end
