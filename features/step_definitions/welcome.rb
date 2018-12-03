Given (/^I am on the homepage$/) do
    visit root_path
end

Then (/^I should see the welcome message$/) do
    #expect(response).to have_http_status(:success)
    expect(page).to have_content("Register")
end

When (/^I click About us$/) do
    click_link('About us')
end

Then (/^I should see About us$/) do
    expect(page).to have_content("About us")
end

When (/^I click Terms of Service$/) do
    click_link('Terms of Service')
end

Then (/^I should see Terms of Service$/) do
    expect(page).to have_content("Terms of Service")
end

When (/^I click Privacy Policy$/) do
    click_link('Privacy Policy')
end

Then (/^I should see Privacy Policy$/) do
    expect(page).to have_content("Privacy Policy")
end