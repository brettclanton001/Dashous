require 'spec_helper'

describe QueryService do
  let(:location) do
    OpenStruct.new({
      ip: ip_address,
      city: city,
      state: state,
      country: country
    })
  end
  let(:ip_address) { '192.168.1.100' }
  let(:city) { 'Butte' }
  let(:state) { 'Montana' }
  let(:country) { 'United States' }
  let(:service) { described_class.new(location) }

  describe '#query' do
    subject { service.query }

    it 'should return the location in a human readable format' do
      expect(subject).to eq 'Butte, Montana, United States'
    end

    context 'no city is found' do
      let(:city) { '' }

      it 'should return the ip address instead of trying to format the location' do
        expect(subject).to eq '192.168.1.100'
      end
    end

    context 'location is nil' do
      let(:location) { nil }

      it 'should return an empty string' do
        expect(subject).to eq ''
      end
    end
  end
end
