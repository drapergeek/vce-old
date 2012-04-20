When /^I go to the new course page$/ do
  visit new_course_path
end

When /^I click the create course button$/ do
  click_button "Create Course"
end

Then /^I should "([^"]*)" in the course list$/ do |name|
  within "table#courses" do
    page.should have_content(name)
  end
end
