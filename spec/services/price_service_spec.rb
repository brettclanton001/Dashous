require 'spec_helper'

describe PriceService do
  let!(:api_request) do
    stub_request(:get, 'https://api.cryptonator.com/api/ticker/dash-usd').
      to_return(status: 200, body: api_response, headers: {})
  end
  let(:api_response) do
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

  before do
    Rails.cache.delete(:price_data)
  end

  describe '#current_price' do
    subject { described_class.current_price }

    it 'should report the current price' do
      expect(subject).to eq 9.53
    end
  end

  describe '#connection' do
    subject { described_class.send(:connection) }

    it 'should build a connection' do
      expect(subject).not_to be_nil
    end
  end

  describe '#external_data' do
    subject { described_class.send(:external_data) }

    it 'should get external data' do
      expect(subject.to_json).to eq api_response
    end
  end
end
