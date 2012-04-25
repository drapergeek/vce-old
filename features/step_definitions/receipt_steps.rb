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
  step "I fill in the required fields"
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

Then "I see that the receipt was created" do
  page.should have_css ".received_from:contains('Foo Bar')"
end

Then "the receipted person should have been sent an e-mail" do
  unread_emails_for("foo@bar.com").size.should == 1
  unread_emails_for("foo@bar.com").select do |m|
    m.subject == "4-H Camp 2012 Receipt"
  end.size.should == 1
end

When /^I fill in the following information for campers:$/ do |table|
  table.hashes.each do |camper|
   fill_in("receipt_camper#{camper["num"]}", :with=>camper["name"])
   fill_in("receipt_camper#{camper["num"]}_id", :with=>camper["number"])
   fill_in("receipt_camper#{camper["num"]}_collage", :with=>camper["collage_count"])
   fill_in("receipt_camper#{camper["num"]}_payment", :with=>camper["amount"])
  end
  fill_in("receipt_amount", with: "415.00")
end

Then /^the following campers should exist:$/ do |table|
  table.hashes.each do |camper|
    found_camper = Camper.find_by_number(camper["number"])
    names = camper["name"].split(" ")
    found_camper.fname.should == names[0]
    found_camper.lname.should == names[1]
    found_camper.collage_count.should == camper["collage_count"].to_i
    found_camper.payments.sum(:amount).should eq camper["amount"].to_f
  end
end

When /^I choose (\d+) collages for camper(\d+)$/ do |collage_count, camper|
   fill_in("receipt_camper#{camper}", :with=>"Peter Parker")
   fill_in("receipt_camper#{camper}_id", :with=> FactoryGirl.generate(:camper_number))
   fill_in("receipt_camper#{camper}_collage", :with=>collage_count)
end

Then /^the total payment amount should be "([^"]*)"$/ do |amount|
  amount = amount.to_f
  page.find("#receipt_amount").value.to_f.should == amount
end


