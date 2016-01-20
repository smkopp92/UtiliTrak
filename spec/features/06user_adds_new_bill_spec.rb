# As an authenticated user
# I want to create a utility bill
# So that I can compare my information with the database
# Acceptance Criteria
# [x]I must fill out all the information correctly
# [x]I should be redirected to show page after submitting form
# [x]Incorrect information should raise an error and refresh page

require 'spec_helper'

feature 'user adds a bill to a specific household' do
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
    find_by_id("house#{@household.id}").click
    click_on 'Add a Bill'
    fill_in 'Amount', with: '123.00'
    fill_in 'datepicker', with: '12/12/2015'
    find(:select, "Kind").find(:option, "Electric").select_option
    click_on 'Generate Bill'

    expect(page).to have_content('2015-12-01')
  end

  scenario 'user adds incorrect information to bill' do
    visit new_household_bill_path(@household)
    click_on 'Generate Bill'

    expect(page).to have_content("be blank")
  end
end
