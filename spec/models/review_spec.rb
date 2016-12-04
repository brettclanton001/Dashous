require 'rails_helper'

RSpec.describe Review, type: :model do
  let!(:user1) { create :user }
  let!(:user2) { create :user }
  let!(:trade_request) { create :trade_request, user: user1 }
  let!(:offer) { create :offer, user: user2, trade_request: trade_request }
  let!(:review) do
    create :review,
      offer: offer,
      reviewed_user: user1,
      reviewing_user: user2,
      tone: tone
  end
  let(:tone) { 'positive' }

  describe 'assoiciations' do
    it 'should have associations' do
      expect(review.offer).to eq offer
      expect(review.reviewed_user).to eq user1
      expect(review.reviewing_user).to eq user2
    end
  end

  describe 'validations' do
    it 'only allows supported tones' do
      expect(review.update_attributes(tone: 'negative')).to eq true
      expect(review.update_attributes(tone: 'neutral')).to eq true
      expect(review.update_attributes(tone: 'aggresive')).to eq false
      expect(review.update_attributes(tone: nil)).to eq false
      expect(review.update_attributes(tone: '')).to eq false
    end

    it 'should not allow creation of another duplicate record' do
      new_review = Review.new(
        offer: offer,
        reviewed_user: user1,
        reviewing_user: user2,
        tone: tone
      )
      expect {new_review.save}.to raise_error
    end
  end

  describe 'tone helpers' do
    context 'positive' do
      it 'should have correct tone' do
        expect(review.positive?).to eq true
        expect(review.neutral?).to eq false
        expect(review.negative?).to eq false
      end
    end

    context 'neutral' do
      let(:tone) { 'neutral' }

      it 'should have correct tone' do
        expect(review.positive?).to eq false
        expect(review.neutral?).to eq true
        expect(review.negative?).to eq false
      end
    end

    context 'negative' do
      let(:tone) { 'negative' }

      it 'should have correct tone' do
        expect(review.positive?).to eq false
        expect(review.neutral?).to eq false
        expect(review.negative?).to eq true
      end
    end
  end
end
