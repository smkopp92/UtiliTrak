# As an authenticated user
# I want to see all bills for a month
# So that I can see a breakdown of my costs
# Acceptance Criteria
# [x]The bill show page should have all relevant bills included

feature 'user sees relevant bill information' do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @household = FactoryGirl.create(:household, user_id: @user.id)
    @hid = @household.id
    @bill1 = FactoryGirl.create(:bill, household_id: @hid)
    @data = FactoryGirl.create(:utilitydata)
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password, match: :prefer_exact
    click_on 'Log in'
  end
  scenario 'Relevant bills show on show page for bill' do
    @bill2 = FactoryGirl.create(:bill, household_id: @hid, kind: "Water")
    @bill3 = FactoryGirl.create(:bill, household_id: @hid, kind: "Gas")
    visit households_path

    find_by_id("house#{@household.id}").click

    find_by_id("bill#{@bill1.id}").click
    expect(page).to_not have_content("Please add more bills for this month to see breakdown")
    expect(page).to have_content(@bill1.amount)
    expect(page).to have_content(@bill2.amount)
    expect(page).to have_content(@bill3.amount)
  end
  scenario 'Flash message appears if pie chart has only one element' do
    visit households_path

    find_by_id("house#{@household.id}").click

    find_by_id("bill#{@bill1.id}").click

    expect(page).to have_content("Please add more bills for this month to see breakdown")
  end
end
