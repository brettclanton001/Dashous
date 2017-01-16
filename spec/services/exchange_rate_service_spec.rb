require 'spec_helper'

describe ExchangeRateService do
  let!(:api_request_usd) do
    stub_request(:get, 'https://api.cryptonator.com/api/ticker/dash-usd').
      to_return(status: 200, body: api_response_usd, headers: {})
  end
  let!(:api_request_eur) do
    stub_request(:get, 'https://api.cryptonator.com/api/ticker/dash-eur').
      to_return(status: 200, body: api_response_eur, headers: {})
  end
  let(:api_response_usd) do
    {
      ticker: {
        base: 'DASH',
        target: 'USD',
        price: '9.53477218',
        volume: '2056.78697840',
        change: '0.04682657'
      },
      timestamp: 1481982394,
      success: true,
      error: ''
    }.to_json
  end
  let(:api_response_eur) do
    {
      ticker: {
        base: 'DASH',
        target: 'EUR',
        price: '9.12477218',
        volume: '2056.78697840',
        change: '0.04682657'
      },
      timestamp: 1481982394,
      success: true,
      error: ''
    }.to_json
  end

  before do
    Rails.cache.delete(:price_data)
  end

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
