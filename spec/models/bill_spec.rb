require 'rails_helper'

RSpec.describe Bill, type: :model do
  let(:bill) { FactoryGirl.create(:bill) }

  before(:each) do
    bill
  end
  it 'has correct information' do
    expect(bill).to be_valid
  end
  it 'has no amount' do
    bill.amount = nil
    expect(bill).to_not be_valid
  end
  it 'has no date' do
    bill.date = nil
    expect(bill).to_not be_valid
  end
  it 'has no kind' do
    bill.kind = nil
    expect(bill).to_not be_valid
  end
end
