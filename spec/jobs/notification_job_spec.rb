require 'rails_helper'

RSpec.describe NotificationJob, type: :job do
  let!(:user1) { create :user, username: 'Bob', email: 'bob@email.com' }
  let!(:user2) { create :user, username: 'Ken', email: 'ken@email.com' }
  let!(:trade_request) { create :trade_request, :new_york, user: user1 }
  let!(:offer) { create :offer, user: user2, trade_request: trade_request }

  describe 'offer_created' do
    subject { described_class.perform_now('offer_created', offer.id) }

    it 'should update exchange rate data' do
      expect(NotificationMailer).to receive(:offer_created)
        .with(offer.id).and_call_original
      subject
    end
  end

  describe 'offer_approved' do
    subject { described_class.perform_now('offer_approved', offer.id) }

    it 'should update exchange rate data' do
      expect(NotificationMailer).to receive(:offer_approved)
        .with(offer.id).and_call_original
      subject
    end
  end
end
