# As an authenticated user
# I want to see a list of my households
# So that I can access specific information for each location
# Acceptance Criteria
# [x]The index page should have a list of households
# [x]Each element should be a link to the show page
#
# As an authenticated user
# I want to add a household
# So that I can keep track of all my bills
# Acceptance Criteria
# [x]I must fill out all the information correctly
# [x]I should be redirected to show page after submitting form
# [x]Incorrect information should raise an error and refresh page
require 'spec_helper'

feature 'user sees a list of their households and adds households' do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @household = FactoryGirl.create(:household, user_id: @user.id)
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password, match: :prefer_exact
    click_on 'Log in'
  end
  scenario 'user visits household show page and sees a list their households' do
    visit households_path
    expect(page).to have_content(@household.address)
  end

  scenario 'user adds household' do
    visit new_household_path
    fill_in 'Address', with: '123 Main Street'
    fill_in 'City', with: 'New York'
    fill_in 'State', with: 'NY', match: :prefer_exact
    fill_in 'Zip', with: '01234'
    click_on 'Create Household'
    expect(page).to have_content('123 Main Street')
  end

  scenario 'user adds incorrect information to household' do
    visit new_household_path
    fill_in 'City', with: 'New York'
    fill_in 'State', with: 'NY', match: :prefer_exact
    fill_in 'Zip', with: '01234'
    click_on 'Create Household'
    expect(page).to have_content("be blank")
  end

  scenario 'unauthenticated user adding household' do
    click_link "Sign Out"
    visit new_household_path
    expect(page).to have_content('Need to be signed in to add a house!')
  end

  scenario 'unauthenticated user seeing households' do
    click_link "Sign Out"
    visit households_path
    expect(page).to have_content('Live Smart')
  end
end
