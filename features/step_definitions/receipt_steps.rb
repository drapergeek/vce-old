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

When "I fill in the required fields" do
   fill_in("receipt_fname", :with=>"Foo")
   fill_in("receipt_lname", :with=>"Bar")
   fill_in("receipt_email", :with=>"foo@bar.com")
   fill_in("receipt_phone", :with=>"232-222-2221")
   fill_in("receipt_zip", :with=>"23222")
   fill_in("receipt_camper1", :with=>"Kids Name")
   fill_in("receipt_camper1_id", :with=>"B221")
   choose("Cash")
end

When "I submit the form" do
  click_button("Create Receipt")
end

Then "I should be redirected to the new receipt" do
  page.should have_css ".received_from:contains('Foo Bar')"
end

Then "the receipted person should have been sent an e-mail" do
  unread_emails_for("foo@bar.com").size.should == 1

  unread_emails_for("foo@bar.com").select do |m|
    m.subject == "4-H Camp 2012 Receipt"
  end.size.should == 1
end


