When /^I go to the campers new page$/ do
  visit new_camper_path
end

When /^I fill in the necessary fields$/ do
  select 'Camper', from: 'Position'
  fill_in 'Number', with: 'CB123'
  fill_in 'First Name', with: 'John'
  fill_in 'Last Name', with: 'Smith'
  fill_in 'Middle Name', with: 'William'
  fill_in 'Preferred Name', with: 'Johnny'
  fill_in 'Zip', with: '12346'
  select 'Male', from: 'Gender'
end

When /^I click the create camper button$/ do
  click_button 'Create Camper'
end

Then /^I should see the new camper created$/ do
  page.should have_css "h1", text: "Johnny Smith CB123"
end

When /^I fill in the birthdate as '(\d+)\/(\d+)\/(\d+)'$/ do |month, day, year|
  month_name = Date::MONTHNAMES[month.to_i]
  select month_name, from: "camper[dob(2i)]"
  select day, from: "camper[dob(3i)]"
  select year, from: "camper[dob(1i)]"
end

Then /^I should see the birthday as "([^"]*)"$/ do |date|
  page.should have_css("div#dob",text: "Birthdate: #{date}")
end

When /^I click the edit button$/ do
  click_link "Edit"
end

Then /^I should see the date should be selected as '(\d+)\/(\d+)\/(\d+)'$/ do |month, day, year|
  page.find("#camper_dob_2i").value.should == month
  page.find("#camper_dob_3i").value.should == day
  page.find("#camper_dob_1i").value.should == year
end

When /^I select "([^"]*)" for the room$/ do |room_name|
  select(room_name, for:"camper_room_namer")
end

Then /^its "([^"]*)" should be "([^"]*)"$/ do |attribute, name|
  page.should have_content("#{attribute}: #{name}")
end

Given /^a room exists with a name of "([^"]*)" and a pack name of "([^"]*)"$/ do |room_name, pack_name|
  pack = create(:pack, name: pack_name)
  create(:room, pack:pack, name: room_name)
end
