When (/^I go to the homepage$/) do
    visit root_path
end

Then (/^I should see the welcome message$/) do
    #expect(response).to have_http_status(:success)
    expect(page).to have_content("Register")
end
