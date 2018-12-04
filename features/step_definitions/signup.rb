Given (/^I am on Signup page$/) do
    visit '/account/sign_up'
end

Then (/^I fill in without error$/) do  
    fill_in('Email', :with => 'k@a.com')
    fill_in('Password', :with => '123456')
    fill_in('Password confirmation', :with => '123456')
    click_on('Sign up')
end

Then (/^I confirm$/) do
    $user = User.find_by_email('k@a.com')
    confirmation_token = $user.confirmation_token
    visit '/account/verification?confirmation_token=' + confirmation_token
end

Then (/^I sign in$/) do
    visit '/account/login'  
    fill_in('user_email', :with => 'k@a.com')
    fill_in('user_password', :with => '123456')
    click_button('Log in')
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
