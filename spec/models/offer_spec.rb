require 'spec_helper'

describe Offer do
  let!(:user1) { create :user }
  let!(:user2) { create :user }
  let!(:trade_request) { create :trade_request, user: user1 }
  let!(:review) do
    create :review,
      offer: offer,
      reviewed_user: user1,
      reviewing_user: user2,
      tone: 'positive'
  end
  let!(:offer) do
    create :offer,
      user: user2,
      trade_request: trade_request,
      status: status
  end
  let(:status) { 'pending' }

  describe 'helpers' do

    describe '#reviewed_by?' do

      it 'should return false when this user has made a review on on this offer' do
        expect(offer.reviewed_by?(user1)).to eq false
      end

      it 'should return true when this user has made a review on this offer' do
        expect(offer.reviewed_by?(user2)).to eq true
      end
    end

    describe 'pending?' do
      it 'should have the correct status' do
        expect(offer.pending?).to eq true
        expect(offer.canceled?).to eq false
        expect(offer.approved?).to eq false
        expect(offer.declined?).to eq false
      end
    end

    describe 'canceled?' do
      let(:status) { 'canceled' }

      it 'should have the correct status' do
        expect(offer.pending?).to eq false
        expect(offer.canceled?).to eq true
        expect(offer.approved?).to eq false
        expect(offer.declined?).to eq false
      end
    end

    describe 'approved?' do
      let(:status) { 'approved' }

      it 'should have the correct status' do
        expect(offer.pending?).to eq false
        expect(offer.canceled?).to eq false
        expect(offer.approved?).to eq true
        expect(offer.declined?).to eq false
      end
    end

    describe 'declined?' do
      let(:status) { 'declined' }

      it 'should have the correct status' do
        expect(offer.pending?).to eq false
        expect(offer.canceled?).to eq false
        expect(offer.approved?).to eq false
        expect(offer.declined?).to eq true
      end
    end
  end
end
