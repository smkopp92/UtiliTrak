# As an authenticated user
# I want to update a household
# So that I can keep my information up to data
# Acceptance Criteria
# [x]I must fill out all the information correctly
# [x]I should be redirected to show page after submitting form
# [x]Incorrect information should raise an error and refresh page
#
# As an authenticated user
# I want to delete my household
# so that my information cannot be accessed
# Acceptance Criteria
# [x]Each show page should have a delete button
# [x]Deleting should prompt the user to confirm deletion
# [x]Deleting should return the user to the index page

require 'rails_helper'

feature 'user may edit and delete their own households' do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @household = FactoryGirl.create(:household, user_id: @user.id)
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password, match: :prefer_exact
    click_on 'Log in'
  end
  scenario 'user is able to delete households' do
    visit households_path

    click_on "Delete Household"

    expect(page).to_not have_content(@household.address)
  end

  scenario 'user is able to edit households they created' do
    visit households_path

    click_on "Edit Household"
    fill_in 'Address', with: "20 Harbor Rd."
    click_button "Update Household"

    expect(page).to have_content("20 Harbor Rd.")
  end
end
