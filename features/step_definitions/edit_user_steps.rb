# Tests for unsuccessful user edits
# -----------------------------------

# Given a user visits his user edit page
Given /^a user visits his user edit page$/ do
  let(:user) { FactoryGirl.create(:user) }
  visit edit_user_path(user)
end

# When he submits invalid profile information
When /^he submits invalid profile information$/ do  
  fill_in "Email", with: "monkey_wrench"
  click_button "Save changes"
end

# Then he should see a bad edit error message
Then /^he should see a bad edit error message$/ do
  page.should have_selector('div.alert.alert-error')
end


# Tests for successful user edits
# -----------------------------------
Given /^the user submits valid profile information$/ do
  fill_in "Name",             with: "newguy"
  fill_in "Email", with: "user@foo.com"
  fill_in "Password",         with: user.password
  fill_in "Confirm Password", with: user.password
  click_button "Save changes"
end

Then /^he should see a success message$/ do
  page.should have_selector('div.alert.alert-success')
end
