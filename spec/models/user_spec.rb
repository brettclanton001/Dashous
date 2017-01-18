require 'spec_helper'

describe User do
  let!(:user1) { create :user }
  let!(:user2) { create :user }
  let!(:user3) { create :user }
  let!(:trade_request1) { create :trade_request, :new_york, user: user1 }
  let!(:trade_request2) { create :trade_request, :stamford, user: user1 }
  let!(:trade_request3) { create :trade_request, :stamford, user: user2 }
  let!(:trade_request4) { create :trade_request, :stamford, user: user3 }
  let!(:offer1) { create :offer, user: user2, trade_request: trade_request1 }
  let!(:offer2) { create :offer, user: user2, trade_request: trade_request2 }
  let!(:offer3) { create :offer, user: user3, trade_request: trade_request2 }
  let!(:offer4) { create :offer, user: user1, trade_request: trade_request3 }

  let(:user) { user1 }

  describe 'associations' do
    it 'has trade requests' do
      expect(user.trade_requests).to match_array [trade_request1, trade_request2]
    end

    it 'has offers' do
      expect(user.offers).to match_array [offer4]
    end

    it 'has trade request offers' do
      expect(user.trade_request_offers).to match_array [offer1, offer2, offer3]
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password).on(:create) }
    it { is_expected.to validate_presence_of(:password_confirmation).on(:create) }
    it { is_expected.to validate_uniqueness_of(:username) }

    it 'validates username' do
      expect(user.update_attributes(username: 'JoeShmo123')).to eq true
      expect(user.update_attributes(username: 'Joe Shmo123')).to eq false
      expect(user.update_attributes(username: 'Joe.Shmo123')).to eq false
      expect(user.update_attributes(username: 'Joe/Shmo123')).to eq false
      expect(user.update_attributes(username: 'Joe%Shmo123')).to eq false
      expect(user.update_attributes(username: 'Joe^Shmo123')).to eq false
      expect(user.update_attributes(username: 'Joe?Shmo123')).to eq false
    end

    it 'validates email uniqueness' do
      dup_user = build(:user, email: user1.email)
      expect(dup_user.valid?).to be false
      expect(dup_user.errors[:email]).to eq ["has already been taken"]
    end
  end
end
