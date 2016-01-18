# As an authenticated user
# I want to edit my utility bills
# So that I can update any incorrect information
# Acceptance Criteria
# []I must fill out all the information correctly
# []I should be redirected to show page after submitting form
# []Incorrect information should raise an error and refresh page
#
# As an authenticated user
# I want to delete my utility bills
# So that my information cannot be accessed
# Acceptance Criteria
# []Each show page should have a delete button
# []Deleting should prompt the user to confirm deletion
# []Deleting should return the user to the index page

require 'rails_helper'

feature 'user may edit and delete their own bills' do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @household = FactoryGirl.create(:household, user_id: @user.id)
    @bill = FactoryGirl.create(:bill, household_id: @household.id)
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password, match: :prefer_exact
    click_on 'Log in'
  end
  scenario 'user is able to delete households' do
    visit households_path

    click_on @household.address

    click_on "Delete Bill"

    expect(page).to_not have_content(@bill.amount)
  end

  scenario 'user is able to edit households they created' do
    visit households_path

    click_on @household.address

    click_on "Edit Bill"
    fill_in 'Amount', with: "10000000"
    click_button "Update Bill"

    expect(page).to have_content("10000000")
  end
end
