require 'spec_helper'

describe ExchangeRateService do
  let!(:prices) { stub_price 10, 'usd' => 9.53477218, 'eur' => 9.12477218 }

  describe '#current_price' do
    subject { described_class.current_price }

    it 'should report the current price' do
      expect(subject).to eq 9.53
    end

    context 'usd' do
      subject { described_class.current_price('usd') }

      it 'should report the current price' do
        expect(subject).to eq 9.53
      end
    end

    context 'eur' do
      subject { described_class.current_price('eur') }

      it 'should report the current price' do
        expect(subject).to eq 9.12
      end
    end
  end

  describe '#connection' do
    subject { described_class.send(:connection) }

    it 'should build a connection' do
      expect(subject).not_to be_nil
    end
  end
end
