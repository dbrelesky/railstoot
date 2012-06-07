
# And the user has an account
Given /^the user has an account$/ do
  @user =  User.create(name: "Bill Clinton", email: "willy@whitehouse.com", password: "foobar", password_confirmation: "foobar")
end

# And the user submits valid signin information
And /^the user submits valid signin information$/ do
  fill_in "Email", with: @user.email
  fill_in "Password", with: @user.password  
  click_button "Sign in"
end

When /^he visits the user index page$/ do
  visit users_path
end

Then /^he should see a list of users$/ do
  User.all.each do |user|
    page.should have_selector('li', text: "user.name")
  end
end

And /^the page should have a proper title$/ do
  page.should have_selector('title', text: "All users")
end

And /^the page should have a proper page heading$/ do
  page.should have_selector('h1', text: "All users")
end
