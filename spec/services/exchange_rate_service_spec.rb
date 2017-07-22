require 'spec_helper'

describe ExchangeRateService do
  let!(:prices) { stub_price 10, 'usd' => 9.53477218, 'eur' => 9.12477218 }

  describe '#current_price' do
    let(:formatted) { false }
    subject { described_class.current_price(currency, formatted) }

    context 'usd' do
      let(:currency) { 'usd' }

      it 'should report the current price' do
        expect(subject).to eq 9.53
      end

      context 'formatted' do
        let(:formatted) { true }

        it 'should report the current price formatted' do
          expect(subject).to eq '$9.53'
        end
      end
    end

    context 'eur' do
      let(:currency) { 'eur' }

      it 'should report the current price' do
        expect(subject).to eq 9.12
      end

      context 'formatted' do
        let(:formatted) { true }

        it 'should report the current price formatted' do
          expect(subject).to eq '€9.12'
        end
      end
    end
  end

  describe '#local_current_price' do
    let(:formatted) { false }
    let(:user) { nil }
    subject { described_class.local_current_price(user, formatted) }

    it 'should default to usd' do
      expect(subject).to eq 9.53
    end

    context 'user with usd set' do
      let(:user) { create :user, currency: :usd }

      it 'should report usd' do
        expect(subject).to eq 9.53
      end
    end

    context 'user with eur set' do
      let(:user) { create :user, currency: :eur }

      it 'should report eur' do
        expect(subject).to eq 9.12
      end

      context 'formatted' do
        let(:formatted) { true }

        it 'should report the current price formatted' do
          expect(subject).to eq '€9.12'
        end
      end
    end
  end

  describe '#updated_at' do
    subject { described_class.updated_at }

    it 'returns the last updated time' do
      expect(subject.class).to eq ActiveSupport::TimeWithZone
      expect(subject).to be_within(1.minute).of(Time.now)
    end
  end

  describe '#connection' do
    subject { described_class.send(:connection) }

    it 'should build a connection' do
      expect(subject).not_to be_nil
    end
  end
end
