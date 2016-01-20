# As an authenticated user
# I want to see a list of utility bills
# So that I can track my progress over the course of time
# Acceptance Criteria
# [x]The household show page should have a list of bills
# [x]Each element should be a link to the show page
#
# As an authenticated user
# I want to see a utility bill
# So that I can see how energy conscious I am
# Acceptance Criteria
# [x]The show page should have all relevant information for that bill
# [x]The show page should have a comparison of relevant utility data
feature 'user sees relevant bill information' do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @household = FactoryGirl.create(:household, user_id: @user.id)
    @bill1 = FactoryGirl.create(:bill, household_id: @household.id)
    @bill2 = FactoryGirl.create(:bill, household_id: @household.id, kind: "Water")
    @data = FactoryGirl.create(:utilitydata)
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password, match: :prefer_exact
    click_on 'Log in'
  end
  scenario 'user is able to see a list of bills for a household' do
    visit households_path

    find_by_id("house#{@household.id}").click

    expect(page).to have_content(@bill1.date)
    expect(page).to have_content(@bill2.date)
  end
  scenario 'user clicks on a bill to see bill specific data' do
    visit households_path

    find_by_id("house#{@household.id}").click

    find_by_id("bill#{@bill1.id}").click

    expect(page).to have_content(@bill1.amount)
  end
  scenario 'Relevant data shows on show page for bill' do
    visit households_path

    find_by_id("house#{@household.id}").click

    find_by_id("bill#{@bill1.id}").click

    expect(page).to have_content(@data.amount)
  end
end
