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


