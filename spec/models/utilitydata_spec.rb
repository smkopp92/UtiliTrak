require 'rails_helper'

RSpec.describe Utilitydata, type: :model do
  let(:utilitydata) { FactoryGirl.create(:utilitydata) }

  before(:each) do
    utilitydata
  end
  it 'has correct information' do
    expect(utilitydata).to be_valid
  end
  it 'has no amount' do
    utilitydata.amount = nil
    expect(utilitydata).to_not be_valid
  end
  it 'has no date' do
    utilitydata.date = nil
    expect(utilitydata).to_not be_valid
  end
  it 'has no kind' do
    utilitydata.kind = nil
    expect(utilitydata).to_not be_valid
  end
  it 'has no state' do
    utilitydata.state = nil
    expect(utilitydata).to_not be_valid
  end
end
