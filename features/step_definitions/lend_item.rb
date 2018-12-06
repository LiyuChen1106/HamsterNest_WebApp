Then  (/^I go to create new item link$/) do
  click_on ('New Item')
end

Then  (/^I create a new book$/) do
  visit new_user_profile_item_path($user.id)
  fill_in('item_item_name', :with => 'F.U Money')
  fill_in('item_description', :with => 'Teach you how to make money')
  # select('Books', :from=>'item_category_id').select_option
  click_button('Create')
end

Then  (/^I see my items$/) do
  visit user_profile_items_path(:user_profile_id =>$user.user_profile_id)
end