require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  before(:each) do
    user
  end
  it 'has correct information' do
    expect(user).to be_valid
  end
  it 'has no username' do
    user.username = nil
    expect(user).to_not be_valid
  end
  it 'has incorrect email' do
    user.email = ".com"
    expect(user).to_not be_valid
  end
  it 'has a matching password confirmation for the password' do
    user.password = 'password'
    user.password_confirmation = 'not the same password'

    expect(user).to_not be_valid
    expect(user.errors[:password_confirmation]).to_not be_blank
  end
end
