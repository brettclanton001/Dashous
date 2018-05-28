require 'spec_helper'

describe CountryService do
  let(:service) { described_class.new(ip) }

  describe '#lookup' do
    subject { service.lookup }

    context 'localhost' do
      let(:ip) { '::1' }

      it 'should lookup ip' do
        expect(subject).to eq({
          geoname_id: nil,
          is_in_european_union: false,
          iso_code: nil,
          name: nil
        })
      end
    end

    context 'France' do
      let(:ip) { '79.93.164.80' }

      it 'should lookup ip' do
        expect(subject).to eq({
          geoname_id: 3017382,
          is_in_european_union: true,
          iso_code: 'FR',
          name: 'France'
        })
      end
    end

    context 'UK' do
      let(:ip) { '82.1.185.172' }

      it 'should lookup ip' do
        expect(subject).to eq({
          geoname_id: 2635167,
          is_in_european_union: true,
          iso_code: 'GB',
          name: 'United Kingdom'
        })
      end
    end

    context 'US' do
      let(:ip) { '204.48.19.88' }

      it 'should lookup ip' do
        expect(subject).to eq({
          geoname_id: 6252001,
          is_in_european_union: false,
          iso_code: 'US',
          name: 'United States'
        })
      end
    end
  end
end
