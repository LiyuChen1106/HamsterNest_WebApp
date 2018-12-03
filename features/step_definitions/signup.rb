Given (/^I am on Signup page$/) do
    visit '/account/sign_up'
end

Then (/^I fill in without error$/) do  
    fill_in('Email', :with => 'k@a.com')
    fill_in('Password', :with => '123456')
    fill_in('Password confirmation', :with => '123456')
    expect {click_on('Sign up')}.to raise_error
end

Then (/^I see successful message$/) do
end

Then (/^I fill in wrong email$/) do
    fill_in('Email', :with => 'a')
    fill_in('Password', :with => '123456')
    fill_in('Password confirmation', :with => '123456')
    click_on('Sign up')
end

Then (/^I see error message and remain in Signup page$/) do
    page.has_xpath?('/account/sign_up')
end

Then (/^I click confirmation instruction$/) do
    click_on ("Didn't receive confirmation instructions?")
end

Then (/^I see confirmation instruction page$/) do
    page.should have_content("Resend confirmation instructions")
end
