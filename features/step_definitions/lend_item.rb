Given (/^I am signed in$/) do
  # User.create([{ email: 'k@a.com', password: '123456'}])
  visit '/account/login'
  fill_in('user_email', :with => 'k@a.com')
  fill_in('user_password', :with => '123456')
  click_button('Log in')
end

Then  (/^I go to create new item link$/) do
  click_on ('New Item')
end

Then  (/^I create a new book$/) do
  page.should have_content ("Item Name")
  fill_in('item_item_name', :with => 'F.U Money')
  fill_in('item_description', :with => 'Teach you how to make money')
  fill_in('item_category_id', :with => 'Books')
  click_button('Create')
end

Then  (/^I post the book$/) do
  # visit '/account/login'
end