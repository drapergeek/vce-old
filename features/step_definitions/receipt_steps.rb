Given "I am logged in as a user" do
  user = Factory.create(:user)
  user.roles << Factory.create(:role)
  visit(new_session_path)
  fill_in("email", :with=>user.email)
  fill_in("password", :with=>user.password)
  click_button("Log In")
end

When "I go to the receipts new page" do
  visit(new_receipt_path)
end

Then "I should see the receipts form" do

  page.should have_css("#new_receipt")
end
