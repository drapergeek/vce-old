When /^I go to the new school page/ do
  visit extras_path
  click_link "Schools"
  click_link "New School"
end

When /^I fill in "([^"]*)" for the name$/ do |name|
  fill_in "Name", with: name
end

When /^I click the create school button$/ do
  click_button "Create School"
end

Then /^I should "([^"]*)" in the school list$/ do |name|
  page.should have_css("tr > td", text: name)
end

