Given (/^I am on the homepage$/) do
    visit root_path
end

When (/^I click the Signup button$/) do
    click_on "register"
end

Then (/^I should move to Signup page$/) do

end

