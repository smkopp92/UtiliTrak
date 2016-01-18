# As an authenticated user
# I want to create a utility bill
# So that I can compare my information with the database
# Acceptance Criteria
# []I must fill out all the information correctly
# []I should be redirected to show page after submitting form
# []Incorrect information should raise an error and refresh page

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
  scenario 'user creates a bill for a household' do

    visit households_path
    click_on @household.address
    click_on 'Add a Bill'
    fill_in 'Amount', with: '123.00'
    fill_in 'Date', with: '12/12/2015'
    fill_in 'Kind', with: 'electricity'
    click_on 'Generate Bill'

    expect(page).to have_content('123')
  end

  scenario 'user adds incorrect information to bill' do
    visit new_household_bill_path(@household)
    click_on 'Generate Bill'

    expect(page).to have_content("be blank")
  end
end