require 'rails_helper'

RSpec.describe Household, type: :model do
  let(:household) { FactoryGirl.create(:household) }

  before(:each) do
    household
  end
  it 'has correct information' do
    expect(household).to be_valid
  end
  it 'has no address' do
    household.address = nil
    expect(household).to_not be_valid
  end
  it 'has no city' do
    household.city = nil
    expect(household).to_not be_valid
  end
  it 'has no state' do
    household.state = nil
    expect(household).to_not be_valid
  end
  it 'has incorrect zipcode number' do
    household.zip = 47823047238174382
    expect(household).to_not be_valid
  end
  it 'has no zipcode number' do
    household.zip = nil
    expect(household).to_not be_valid
  end
  it 'has incorrect zipcode type' do
    household.zip = 'pie'
    expect(household).to_not be_valid
  end
  it 'has default occupants set to 1' do
    expect(household.occupants).to eq(1)
  end
  it 'has no occupants' do
    household.occupants = nil
    expect(household).to_not be_valid
  end
end
