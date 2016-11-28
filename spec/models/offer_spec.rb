require 'spec_helper'

describe Offer do
  let!(:offer) do
    create :offer,
      status: status
  end
  let(:status) { 'pending' }

  describe 'status helpers' do

    context 'pending' do

      it 'should have the correct status' do
        expect(offer.pending?).to eq true
        expect(offer.canceled?).to eq false
        expect(offer.approved?).to eq false
        expect(offer.declined?).to eq false
      end
    end

    context 'canceled' do
      let(:status) { 'canceled' }

      it 'should have the correct status' do
        expect(offer.pending?).to eq false
        expect(offer.canceled?).to eq true
        expect(offer.approved?).to eq false
        expect(offer.declined?).to eq false
      end
    end

    context 'approved' do
      let(:status) { 'approved' }

      it 'should have the correct status' do
        expect(offer.pending?).to eq false
        expect(offer.canceled?).to eq false
        expect(offer.approved?).to eq true
        expect(offer.declined?).to eq false
      end
    end

    context 'declined' do
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
