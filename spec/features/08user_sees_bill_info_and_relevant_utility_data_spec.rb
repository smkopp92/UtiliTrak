# As an authenticated user
# I want to see a list of utility bills
# So that I can track my progress over the course of time
# Acceptance Criteria
# []The household show page should have a list of bills
# []Each element should be a link to the show page
#
# As an authenticated user
# I want to see a utility bill
# So that I can see how energy conscious I am
# Acceptance Criteria
# []The show page should have all relevant information for that bill
# []The show page should have a comparison of relevant utility data
feature 'user sees relevant bill information' do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @household = FactoryGirl.create(:household, user_id: @user.id)
    @bill1 = FactoryGirl.create(:bill, household_id: @household.id)
    @bill2 = FactoryGirl.create(:bill, household_id: @household.id)
    @data = FactoryGirl.create(:utilitydata)
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password, match: :prefer_exact
    click_on 'Log in'
  end
  scenario 'user is able to see a list of bills for a household' do
    visit households_path

    click_on @household.address

    expect(page).to have_content(@bill1.amount)
    expect(page).to have_content(@bill2.amount)
  end
  scenario 'user clicks on a bill to see bill specific data' do
    visit households_path

    click_on @household.address

    click_on @bill1.amount

    expect(page).to have_content(@bill1.amount)
  end
  scenario 'Relevant data shows on show page for bill' do
    visit households_path

    click_on @household.address

    click_on @bill1.amount

    expect(page).to have_content(@data.amount)
  end
end
